//
//  PokemonService.swift
//  PokemonAPI
//
//  Created by Michael Conchado on 18/04/23.
//

import Foundation

final class PokemonService: FetchingPokemonProtocol {
    
    private let pokeItemListLoader: PokeItemsLoader
    private let pokemonListloader: PokemonLoader
    
    init(
        pokeListLoader: PokeItemsLoader,
        pokemonListloader: PokemonLoader
    ) {
        self.pokeItemListLoader = pokeListLoader
        self.pokemonListloader = pokemonListloader
    }
    
    func getPokeItemList(url: URL, completion: @escaping (Result<[Pokemon], Error>) -> Void) {
        pokeItemListLoader.load(url: url) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(pokeList):
                self.getPokemonList(pokemonURLs: pokeList.map { $0.url }) { completion($0) }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    func getPokemonList(pokemonURLs: [String], completion: @escaping (Result<[Pokemon], Error>) -> Void) {
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
                case let .failure(error):
                    errors.append(error)
                }
            }
        }
        dispatchGroup.notify(queue: .main) {
            errors.isEmpty ? completion(.success(loadedPokemon)) : completion(.failure(errors[0]))
        }
    }
}
