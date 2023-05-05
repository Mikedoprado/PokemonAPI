//
//  ComposerPokemonList.swift
//  PokemonAPI
//
//  Created by Michael Conchado on 21/04/23.
//

import SwiftUI
import Combine

struct ComposerPokemonList {
    @ObservedObject var deviceOrientationViewModel: DeviceOrientationViewModel
    @ObservedObject var pokelistViewModel: ListPokemonViewModel
    
    func compose() -> NavigationPokeList {
        NavigationPokeList(
            list: pokelistViewModel.pokeList,
            textfieldSearch: $pokelistViewModel.textSearching,
            isLoading: $pokelistViewModel.isLoading,
            invalidSearch: $pokelistViewModel.invalidSearch,
            connectivity: $pokelistViewModel.connectivity,
            isLandscape: $deviceOrientationViewModel.isLandscape,
            filterBy: $pokelistViewModel.filterBy
        )
    }
}

final class Service {
    private var httpClient: HTTPClient
    var nextPage: String?
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }

    private func getListPokeItem(url: URL) -> AnyPublisher<ListPokeItems, Error> {
        httpClient
            .getPublisher(url: url)
            .tryMap(PokeListMapper.map)
            .eraseToAnyPublisher()
    }
    
    func getPokemons(url: URL) -> AnyPublisher<Pokemon, Error> {
        httpClient
            .getPublisher(url: url)
            .tryMap(PokemonMapper.map)
            .eraseToAnyPublisher()
    }

    func getPokemonList(url: URL) -> AnyPublisher<[Pokemon], Error> {
        return getListPokeItem(url: url)
            .flatMap { [weak self] pokeItemList -> AnyPublisher<[Pokemon], Error> in
                guard let self = self else { return Empty<[Pokemon], Error>().eraseToAnyPublisher() }
                self.nextPage = pokeItemList.next
                let pokemonPublisher = getPokeItems(pokeItemList)
                return Publishers.Sequence(sequence: pokemonPublisher)
                    .flatMap { $0 }
                    .collect()
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    private func getPokeItems(_ listItems: ListPokeItems) -> [AnyPublisher<Pokemon, Error>] {
        let searchPokemons = listItems.pokemon.map({ $0.map { $0.pokemon } })
        guard let items = listItems.results != nil ? listItems.results : searchPokemons else { return [] }
        let pokemonPublisher = items.map { item  in
            guard let url = URL(string: item.url) else { return Empty<Pokemon, Error>().eraseToAnyPublisher() }
            return self.getPokemons(url: url)
        }
        return pokemonPublisher
    }
}
