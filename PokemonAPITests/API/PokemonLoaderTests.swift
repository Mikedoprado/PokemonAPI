//
//  LoaderTests.swift
//  PokemonAPITests
//
//  Created by Michael Conchado on 15/04/23.
//

import XCTest
import Foundation
@testable import PokemonAPI

final class PokemonLoaderTests: XCTestCase {

    func test_deliverErrorOnNot200HTTPResponse() {
        let (sut, client) = makeSUT()

        let samples = [199, 201, 300, 400, 500]
        
        samples.enumerated().forEach { index, code in
            expect(sut: sut, completeWith: .failure(PokemonLoader.Error.invalidData)) {
                let invalidData = Data("invalid data".utf8)
                client.complete(withStatusCode: code, data: invalidData, at: index)
            }
        }
    }
    
    func test_deliverErrorOnNot2xxHTTPResponse() {
        let (sut, client) = makeSUT()

        let samples = [200, 201, 250, 280, 299]
        
        samples.enumerated().forEach { index, code in
            expect(sut: sut, completeWith: .failure(PokemonLoader.Error.invalidData)) {
                let invalidJSON = Data("invalid json".utf8)
                client.complete(withStatusCode: code, data: invalidJSON, at: index)
            }
        }
    }
    
    func test_deliverErrorOn200HTTPResponseWithInvalidData() {
        let (sut, client) = makeSUT()
        
        expect(sut: sut, completeWith: .failure(PokemonLoader.Error.invalidData)) {
            let invalidData = Data("invalidData".utf8)
            client.complete(withStatusCode: 200, data: invalidData)
        }
    }
    
    func test_load_deliversItemsOn200HTTPResponseWithJSONItems() {
        let (sut, client) = makeSUT()

        let pokemon1 = makePokemon(
            id: 25,
            name: "Pikachu",
            types: [Types(type: TypeInfo(name: "Electric"))],
            abilities: [Ability(ability: AbilityInfo(name: "Static"))],
            sprites: Sprites(
                frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png",
                other: PokemonLoaderTests.Other(
                    officialArtWork: OfficialArtWork(
                        frontDefault: "somo artwork"))),
            moves: [Move(move: MoveInfo(name: "Thunderbolt"))])
        
        expect(sut: sut, completeWith: .success(pokemon1.model.item)) {
            let json = makeItemsJSONFromItems(pokemon1.model)
            client.complete(withStatusCode: 200, data: json)
        }
    }

    // MARK: Helpers
    
    private func makeSUT(
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> (sut: PokemonLoader, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = PokemonLoader(client: client)
        trackForMemoryLeak(instance: client, file: file, line: line)
        trackForMemoryLeak(instance: sut, file: file, line: line)
        return (sut, client)
    }
    
    private func expect(
        sut: PokemonLoader,
        completeWith expectedResult: PokemonLoader.Result,
        action: () -> Void,
        url: URL = URL(string: "http://any-url.com")!,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        let exp = expectation(description: "waiting for completion")
        sut.load(url: url) { receivedResult in
            switch (receivedResult, expectedResult) {
            case let (.success(receivedItems), .success(expectedItems)):
                XCTAssertEqual(receivedItems, expectedItems, file: file, line: line)
            case let (.failure(receivedError), .failure(expectedError)):
                XCTAssertEqual(receivedError as! PokemonLoader.Error, expectedError as! PokemonLoader.Error, file: file, line: line)
            default: XCTFail("Expected result \(expectedResult) got \(receivedResult) instead", file: file, line: line)
            }
            exp.fulfill()
        }
        action()
        
        wait(for: [exp], timeout: 1.0)
    }
    
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
                moves: moves.map { $0.move.name },
                artwork: sprites.other.officialArtWork.frontDefault)
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
