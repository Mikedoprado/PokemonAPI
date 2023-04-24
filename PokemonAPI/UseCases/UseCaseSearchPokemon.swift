//
//  UseCaseSearchPokemon.swift
//  PokemonAPI
//
//  Created by Michael Conchado on 23/04/23.
//

import Foundation

final class UseCaseSearchPokemon {

    typealias Result = Swift.Result<[Pokemon], Error>
    private var service: FetchingPokemonProtocol
    
    init(service: FetchingPokemonProtocol) {
        self.service = service
    }
    
    func getPokemons(url: URL, completion: @escaping (Result) -> Void) {
        service.getPokeItemList(url: url, completion: completion)
    }
    
    func searchingByFilter(
        searchText: String,
        filterBy: TabBarItem,
        completion: @escaping (Result) -> Void
    ) {
        switch filterBy {
        case .name:
            let urlString = Endpoint.getPokemonByName(searchText.lowercased()).url(baseURL: baseURL).absoluteString
            self.searchPokemon(urlString: urlString, completion: completion)
        case .type:
            let url = Endpoint.getPokemonByType(searchText.lowercased()).url(baseURL: baseURL)
            self.getPokemons(url: url, completion: completion)
        case .ability:
            let url = Endpoint.getPokemonByAbility(searchText.lowercased()).url(baseURL: baseURL)
            self.getPokemons(url: url, completion: completion)
        }
    }
    
    private func searchPokemon(urlString: String, completion: @escaping (Result) -> Void) {
        service.getPokemonList(pokemonURLs: [urlString], completion: completion)
    }
    
}
