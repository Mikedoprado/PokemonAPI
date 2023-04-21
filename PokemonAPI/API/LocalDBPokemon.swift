//
//  LocalDBPokemon.swift
//  PokemonAPI
//
//  Created by Michael Conchado on 20/04/23.
//
import Foundation

final class LocalDBPokemon {
    private let userDefaults = UserDefaults.standard
    
    func save(pokemons: [LocalPokemon]) {
        do {
            let encoder = JSONEncoder()
            let encodedPokemons = try encoder.encode(pokemons)
            userDefaults.set(encodedPokemons, forKey: "pokemons")
        } catch {
            print("Error saving pokemons: \(error.localizedDescription)")
        }
    }
    
    func getPokemons(completion: (Result<[Pokemon], Error>) -> Void) {
        if let savedPokemons = userDefaults.object(forKey: "pokemons") as? Data {
            do {
                let decoder = JSONDecoder()
                let pokemons = try decoder.decode([LocalPokemon].self, from: savedPokemons)
                completion(.success(pokemons.map { LocalPokemonMapper.map(localPokemon: $0) }))
            } catch let error {
                completion(.failure(error))
            }
        }
    }
}

