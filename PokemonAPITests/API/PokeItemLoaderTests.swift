//
//  PokeItemLoaderTests.swift
//  PokemonAPITests
//
//  Created by Michael Conchado on 18/04/23.
//

import XCTest
import Foundation
@testable import PokemonAPI

final class PokeItemLoaderTests: XCTestCase {

    func test_deliverErrorOnNot200HTTPResponse() {
        let (sut, client) = makeSUT()

        let samples = [199, 201, 300, 400, 500]
        
        samples.enumerated().forEach { index, code in
            expect(sut: sut, completeWith: .failure(PokeItemsLoader.Error.invalidData)) {
                let invalidData = makeItemsJSONFromItems([])
                client.complete(withStatusCode: code, data: invalidData, at: index)
            }
        }
    }
    
    func test_deliverErrorOnNot2xxHTTPResponse() {
        let (sut, client) = makeSUT()

        let samples = [200, 201, 250, 280, 299]
        
        samples.enumerated().forEach { index, code in
            expect(sut: sut, completeWith: .failure(PokeItemsLoader.Error.invalidData)) {
                let invalidJSON = Data("invalid json".utf8)
                client.complete(withStatusCode: code, data: invalidJSON, at: index)
            }
        }
    }
    
    func test_deliverErrorOn200HTTPResponseWithInvalidData() {
        let (sut, client) = makeSUT()
        
        expect(sut: sut, completeWith: .failure(PokeItemsLoader.Error.invalidData)) {
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

        let pokeItem1 = makePokeItem(
            name: "Pikachu",
            url: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png")

        let pokeItem2 = makePokeItem(
            name: "Clefairy",
            url: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/35.png")

        let items = [pokeItem1.model, pokeItem2.model]
        
        expect(sut: sut, completeWith: .success(items)) {
            let json = makeItemsJSONFromItems(items)
            client.complete(withStatusCode: 200, data: json)
        }
    }

    // MARK: Helpers
    
    private func makeSUT(
        file: StaticString = #filePath,
        line: UInt = #line
    ) -> (sut: PokeItemsLoader, client: HTTPClientSpy) {
        let client = HTTPClientSpy()
        let sut = PokeItemsLoader(client: client)
        trackForMemoryLeak(instance: client, file: file, line: line)
        trackForMemoryLeak(instance: sut, file: file, line: line)
        return (sut, client)
    }
    
    private func expect(
        sut: PokeItemsLoader,
        completeWith expectedResult: PokeItemsLoader.Result,
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
                XCTAssertEqual(receivedError as! PokeItemsLoader.Error, expectedError as! PokeItemsLoader.Error, file: file, line: line)
            default: XCTFail("Expected result \(expectedResult) got \(receivedResult) instead", file: file, line: line)
            }
            exp.fulfill()
        }
        action()
        
        wait(for: [exp], timeout: 1.0)
    }
    
    private func makePokeItem(name: String, url: String) -> (model: PokeItem, json: [String : Any]) {
        
        let item = PokeItem(name: name, url: url)
        
        let json = [
            "name": name,
            "url": url
        ] as [String : Any]

        return (item, json)
    }

    private func makeItemsJSONFromItems(_ items: [PokeItem]) -> Data {
        let encoder = JSONEncoder()
        let itemsJSON = ["results": items]
        let jsonData = try! encoder.encode(itemsJSON)
        return jsonData
    }
}
