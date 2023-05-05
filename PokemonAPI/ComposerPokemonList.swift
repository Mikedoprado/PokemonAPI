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
    
    init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }

    private func getListPokeItem(url: URL) -> AnyPublisher<[PokeItem], Error> {
        httpClient
            .getPublisher(url: url)
            .tryMap(PokeItemMapper.map)
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
            .flatMap { [weak self] pokeItems -> AnyPublisher<[Pokemon], Error> in
                guard let self = self else { return Empty().eraseToAnyPublisher() }
                let pokemonPublisher = pokeItems.map { item  in
                    guard let url = URL(string: item.url) else { return Empty<Pokemon, Error>().eraseToAnyPublisher() }
                    return self.getPokemons(url: url)
                }
                return Publishers.Sequence(sequence: pokemonPublisher)
                    .flatMap { $0 }
                    .collect()
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
