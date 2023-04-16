//
//  LoaderTests.swift
//  PokemonAPITests
//
//  Created by Michael Conchado on 15/04/23.
//

import XCTest
import Foundation
@testable import PokemonAPI

final class LoaderTests: XCTestCase {
    
    func test_init_doesnNotRequestDataFromURL() {
        let client = HTTPClientSpy()
        
        XCTAssertTrue(client.requestedURLs.isEmpty)
    }
    
    func test_load_requestDataFromURL() {
        let url = anyURL()
        let (sut, client) = makeSUT(url: url)
        
        sut.load { _ in }
        
        XCTAssertEqual(client.requestedURLs, [url])
    }
    
    func test_loadTwice_requestDataFromURL() {
        let url = anyURL()
        let (sut, client) = makeSUT(url: url)

        sut.load { _ in }
        sut.load { _ in }
        
        XCTAssertEqual(client.requestedURLs, [url, url])
    }
    
    func test_deliverErrorOnClientError() {
        let (sut, client) = makeSUT()
        expect(sut: sut, completeWith: .failure(Loader.Error.connectivity)) {
            let clientError = anyNSError()
            client.complete(with: clientError)
        }

    }
    
    func test_deliverErrorOnNot200HTTPResponse() {
        let (sut, client) = makeSUT()

        let samples = [199, 201, 300, 400, 500]
        
        samples.enumerated().forEach { index, code in
            expect(sut: sut, completeWith: .failure(Loader.Error.invalidData)) {
                let invalidData = makeItemsJSONFromItems([])
                client.complete(withStatusCode: code, data: invalidData, at: index)
            }
        }
    }
    
    func test_deliverErrorOn200HTTPResponseWithInvalidData() {
        let (sut, client) = makeSUT()
        
        expect(sut: sut, completeWith: .failure(Loader.Error.invalidData)) {
            let invalidData = Data("invalidData".utf8)
            client.complete(withStatusCode: 200, data: invalidData)
        }
    }
    
    func test_deliverNoItemsOn200HTTPResponseWithEmptyJSON() {
        let (sut, client) = makeSUT()
        
        expect(sut: sut, completeWith: .success([])) {
            let emptyListJSON = makeItemsJSONFromItems([])
            client.complete(withStatusCode: 200, data: emptyListJSON)
        }
    }
    
    func test_load_deliversItemsOn200HTTPResponseWithJSONItems() {
        let (sut, client) = makeSUT()

        let pokemon1 = makePokemon(
            id: 25,
            name: "Pikachu",
            types: [Types(type: TypeInfo(name: "Electric"))],
            abilities: [Ability(ability: AbilityInfo(name: "Static"))],
            sprites: Sprites(frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png"), moves: [Move(move: MoveInfo(name: "Thunderbolt"))])

        let pokemon2 = makePokemon(
            id: 35,
            name: "Clefairy",
            types: [Types(type: TypeInfo(name: "Fairy"))],
            abilities: [Ability(ability: AbilityInfo(name: "Love"))],
            sprites: Sprites(frontDefault: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/35.png"), moves: [Move(move: MoveInfo(name: "Loving in the air"))])

        let items = [pokemon1.model.item, pokemon2.model.item]

        let jsonItems = [pokemon1.model, pokemon2.model]
        
        expect(sut: sut, completeWith: .success(items)) {
            let json = makeItemsJSONFromItems(jsonItems)
            client.complete(withStatusCode: 200, data: json)
        }
    }
    
    func test_load_doesNotDeliverResultAfterSUTInstancesHasBeenDeallocated() {
        let url = anyURL()
        let client = HTTPClientSpy()
        var sut: Loader? = Loader(url: url, client: client)
        
        var capturedResults = [Loader.Result]()
        sut?.load { capturedResults.append($0) }
        
        sut = nil
        client.complete(withStatusCode: 200, data: makeItemsJSONFromItems([]))
        
        XCTAssertTrue(capturedResults.isEmpty)
        
    }
    
    // MARK: Helpers
    
    private func makeSUT(
        url: URL = URL(string: "http://any-url.com")!,
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> (sut: Loader, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = Loader(url: url, client: client)
        trackForMemoryLeak(instance: client, file: file, line: line)
        trackForMemoryLeak(instance: sut, file: file, line: line)
        return (sut, client)
    }
    
    private func expect(
        sut: Loader,
        completeWith expectedResult: Loader.Result,
        action: () -> Void,
        file: StaticString = #filePath,
        line: UInt = #line
    ) {
        let exp = expectation(description: "waiting for completion")
        sut.load { receivedResult in
            switch (receivedResult, expectedResult) {
            case let (.success(receivedItems), .success(expectedItems)):
                XCTAssertEqual(receivedItems, expectedItems, file: file, line: line)
            case let (.failure(receivedError), .failure(expectedError)):
                XCTAssertEqual(receivedError as! Loader.Error, expectedError as! Loader.Error, file: file, line: line)
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
    
    private func anyURL() -> URL {
        return URL(string: "http://any-url.com")!
    }
    
    private func anyNSError() -> NSError {
        return NSError(domain: "error", code: 0)
    }
    
    private func anyData() -> Data {
        return Data("anyData".utf8)
    }
    
    private func makeItemsJSONFromItems(_ items: [Item]) -> Data {
        let encoder = JSONEncoder()
        let itemsJSON = ["items": items]
        let jsonData = try! encoder.encode(itemsJSON)
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
}
