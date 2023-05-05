//
//  PokemonMapper.swift
//  PokemonAPI
//
//  Created by Michael Conchado on 15/04/23.
//

import Foundation

final class PokemonMapper {

    struct Item: Codable {
        let id: Int?
        let name: String?
        let abilities: [Ability]?
        let moves: [Move]?
        let sprites: Sprites?
        let types: [Types]?
        
        var pokemon: Pokemon {
            return Pokemon(
                id: id ?? 0,
                name: name,
                types: types?.map { $0.type.name ?? "" },
                abilities: abilities?.map { $0.ability.name ?? "" },
                sprites: sprites?.frontDefault,
                moves: moves?.map { $0.move.name ?? "" },
                artwork: sprites?.other.officialArtWork.frontDefault)
        }
    }

    struct Ability: Codable {
        let ability: AbilityInfo
    }

    struct AbilityInfo: Codable {
        let name: String?
    }

    struct Move: Codable {
        let move: MoveInfo
    }

    struct MoveInfo: Codable {
        let name: String?
    }

    struct Sprites: Codable {
        let frontDefault: String?
        let other: Other

        enum CodingKeys: String, CodingKey {
            case frontDefault = "front_default"
            case other
        }
    }
    
    struct Other: Codable {
        let officialArtWork: OfficialArtWork
        
        enum CodingKeys: String, CodingKey {
            case officialArtWork = "official-artwork"
        }
    }
    
    struct OfficialArtWork: Codable {
        let frontDefault: String?

        enum CodingKeys: String, CodingKey {
            case frontDefault = "front_default"
        }
    }

    struct Types: Codable {
        let type: TypeInfo
    }

    struct TypeInfo: Codable {
        let name: String?
    }

    private static var OK_200: Int { 200 }
    
    private enum Error: Swift.Error {
        case invalidData
    }
    
    static func map(_ data: Data,_ response: HTTPURLResponse) throws -> Pokemon {
        guard
            response.statusCode == OK_200,
            let item = try? JSONDecoder().decode(Item.self, from: data)
        else { throw Error.invalidData }
        return item.pokemon
    }
}
