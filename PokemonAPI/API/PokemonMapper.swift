//
//  PokemonMapper.swift
//  PokemonAPI
//
//  Created by Michael Conchado on 15/04/23.
//

import Foundation

final class PokemonsMapper {
    
    private struct Root: Decodable {
        let items: [Item]
        var pokemonList: [Pokemon] {
            items.map { $0.item }
        }
    }

    private struct Item: Decodable {
        public let id: Int
        public let name: String
        public let types: [`Type`]
        public let abilities: [Ability]
        public let front_default: String
        public let moves: [Move]
        
        var item: Pokemon {
            return Pokemon(
                id: id,
                name: name,
                types: types.map { $0.name },
                abilities: abilities.map { $0.name } ,
                sprites: front_default,
                moves: moves.map { $0.name })
        }
    }
    
    private struct `Type`: Codable {
        let name: String
    }

    private struct Ability: Codable {
        let name: String
    }

    private struct Move: Codable {
        let name: String
    }
    
    private static var OK_200: Int { 200 }
    
    static func map(_ data: Data, from response: HTTPURLResponse) -> Loader.Result {
        guard
            response.statusCode == OK_200,
            let root = try? JSONDecoder().decode(Root.self, from: data)
        else { return .failure(Loader.Error.invalidData) }
        return  .success(root.pokemonList)
    }
}
