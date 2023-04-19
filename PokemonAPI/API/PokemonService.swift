//
//  PokemonService.swift
//  PokemonAPI
//
//  Created by Michael Conchado on 18/04/23.
//

import Foundation

final class PokemonService {
    
    private let pokeItemListLoader: PokeItemsLoader
    private let pokemonListloader: PokemonLoader
    
    init(
        pokeListLoader: PokeItemsLoader,
        pokemonListloader: PokemonLoader
    ) {
        self.pokeItemListLoader = pokeListLoader
        self.pokemonListloader = pokemonListloader
    }
    
    enum Error: Swift.Error {
        case invalidURL
        case invalidData
    }
    
    func getPokeItemList(completion: @escaping (Result<[Pokemon], Error>) -> Void) {
        let url = Endpoint.getPokeList.url(baseURL: baseURL)
        pokeItemListLoader.load(url: url) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(pokeList):
                self.getPokemonList(pokemonURLs: pokeList.map { $0.url }) { completion($0) }
            case .failure:
                completion(.failure(Error.invalidData))
            }
        }
    }

    
    private func getPokemonList(pokemonURLs: [String], completion: @escaping (Result<[Pokemon], Error>) -> Void) {
        let dispatchGroup = DispatchGroup()
        var loadedPokemon: [Pokemon] = []
        var errors: [Error] = []
        for string in pokemonURLs {
            guard let url = URL(string: string) else { return }
            dispatchGroup.enter()
            self.pokemonListloader.load(url: url) { result in
                defer {
                    dispatchGroup.leave()
                }
                switch result {
                case let .success(pokemon):
                    loadedPokemon.append(pokemon)
                case .failure:
                    errors.append(Error.invalidData)
                }
            }
        }
        dispatchGroup.notify(queue: .main) {
            errors.isEmpty ? completion(.success(loadedPokemon)) : completion(.failure(errors[0]))
        }
    }
}
