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
    
    struct Item: Codable {
        let id: Int
        let name: String
        let abilities: [Ability]
        let moves: [Move]
        let sprites: Sprites
        let types: [Types]
        
        var item: Pokemon {
            return Pokemon(
                id: id,
                name: name,
                types: types.map { $0.type.name },
                abilities: abilities.map { $0.ability.name },
                sprites: sprites.frontDefault,
                moves: moves.map { $0.move.name })
        }
    }

    struct Ability: Codable {
        let ability: AbilityInfo
    }

    struct AbilityInfo: Codable {
        let name: String
    }

    struct Move: Codable {
        let move: MoveInfo
    }

    struct MoveInfo: Codable {
        let name: String
    }

    struct Sprites: Codable {
        let frontDefault: String

        enum CodingKeys: String, CodingKey {
            case frontDefault = "front_default"
        }
    }

    struct Types: Codable {
        let type: TypeInfo
    }

    struct TypeInfo: Codable {
        let name: String
    }

    private static var OK_200: Int { 200 }
    
    static func map(_ data: Data, from response: HTTPURLResponse) -> Result<[Pokemon], Swift.Error> {
        guard
            response.statusCode == OK_200,
            let root = try? JSONDecoder().decode(Root.self, from: data)
        else { return .failure(Loader.Error.invalidData) }
        return  .success(root.pokemonList)
    }
}
