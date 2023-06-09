//
//  Service.swift
//  PokemonAPI
//
//  Created by Michael Conchado on 8/05/23.
//
import Combine
import Foundation

final class Service {
    private var httpClient: HTTPClient
    private var nextPage: String?
    
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
                let pokemonPublisher = getPokemonItems(pokeItemList)
                return Publishers.Sequence(sequence: pokemonPublisher)
                    .flatMap { $0 }
                    .collect()
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    private func getPokemonItems(_ listItems: ListPokeItems) -> [AnyPublisher<Pokemon, Error>] {
        let searchPokemons = listItems.pokemon.map({ $0.map { $0.pokemon } })
        guard let items = listItems.results != nil ? listItems.results : searchPokemons else { return [] }
        let pokemonPublisher = items.map { item  in
            guard let url = URL(string: item.url) else { return Empty<Pokemon, Error>().eraseToAnyPublisher() }
            return self.getPokemons(url: url)
        }
        return pokemonPublisher
    }
    
    func loadMorePokemons() -> AnyPublisher<[Pokemon], Error> {
        guard
            let urlString = nextPage,
            let nextUrl = URL(string: urlString)
        else { return Empty<[Pokemon], Error>().eraseToAnyPublisher() }
        return getPokemonList(url: nextUrl)
    }
}
