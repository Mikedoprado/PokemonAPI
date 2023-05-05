//
//  LoaderTests.swift
//  PokemonAPITests
//
//  Created by Michael Conchado on 15/04/23.
//

import XCTest
import Foundation
@testable import PokemonAPI

final class PokemonMapperTests: XCTestCase {

    func test_deliverErrorOnNot200HTTPResponse() throws {
        let samples = [199, 201, 300, 400, 500]
        
        let invalidData = Data("invalidData".utf8)
        try samples.forEach {  code in
            XCTAssertThrowsError(
                try PokemonMapper.map(invalidData, HTTPURLResponse(statusCode: code))
            )
        }
    }
    
    func test_deliverErrorOnNot2xxHTTPResponse() throws {

        let samples = [200, 201, 250, 280, 299]
        let invalidData = Data("invalidData".utf8)
        try samples.forEach {  code in
            XCTAssertThrowsError(
                try PokemonMapper.map(invalidData, HTTPURLResponse(statusCode: code))
            )
        }
    }
    
    func test_deliverErrorOn200HTTPResponseWithInvalidData() {
        let invalidData = Data("invalidData".utf8)
        
        XCTAssertThrowsError(
            try PokemonMapper.map(invalidData, HTTPURLResponse(statusCode: 200))
        )
    }
    
    func test_load_deliversItemsOn200HTTPResponseWithJSONItems() throws {

        let pokemon1 = makePokemon(
            id: 25,
            name: "Pikachu",
            types: [Types(type: TypeInfo(name: "Electric"))],
            abilities: [Ability(ability: AbilityInfo(name: "Static"))],
            sprites: Sprites(
                frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png",
                other: PokemonMapperTests.Other(
                    officialArtWork: OfficialArtWork(
                        frontDefault: "somo artwork"))),
            moves: [Move(move: MoveInfo(name: "Thunderbolt"))])
        
        let json = makeItemsJSONFromItems(pokemon1.model)
        
        let result = try PokemonMapper.map(json, HTTPURLResponse(statusCode: 200))
        
        XCTAssertEqual(result, pokemon1.model.item)
    }

    // MARK: Helpers

    
    private func makePokemon(id: Int, name: String, types: [Types], abilities: [Ability], sprites: Sprites, moves: [Move]) -> (model: Item, json: [String : Any]) {
        
        let item = Item(
            id: id,
            name: name,
            abilities: abilities,
            moves: moves,
            sprites: sprites,
            types: types)
        
        let json = [
            "id": id,
            "name": name,
            "abilities": abilities,
            "moves": moves,
            "sprites": sprites,
            "types": types
        ] as [String : Any]

        return (item, json)
    }

    private func makeItemsJSONFromItems(_ item: Item) -> Data {
        let encoder = JSONEncoder()
        let jsonData = try! encoder.encode(item)
        return jsonData
    }

    struct Item: Codable, Equatable {
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
                moves: moves.map { $0.move.name },
                artwork: sprites.other.officialArtWork.frontDefault)
        }
        
        static func == (lhs: PokemonMapperTests.Item, rhs: PokemonMapperTests.Item) -> Bool {
            return lhs.id == rhs.id
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
}
