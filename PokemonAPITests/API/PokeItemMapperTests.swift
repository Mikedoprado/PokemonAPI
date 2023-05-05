//
//  PokeItemMapperTests.swift
//  PokemonAPITests
//
//  Created by Michael Conchado on 18/04/23.
//

import XCTest
import Foundation
@testable import PokemonAPI

final class PokeItemMapperTests: XCTestCase {

    func test_deliverErrorOnNot200HTTPResponse() throws {
        let samples = [199, 201, 300, 400, 500]
        let invalidData = makeItemsJSONFromItems([])

        try samples.forEach { code in
            XCTAssertThrowsError(
                try PokeItemMapper.map(invalidData, from: HTTPURLResponse(statusCode: code))
            )
        }
    }

    func test_deliverErrorOnNot2xxHTTPResponse() throws {
        let samples = [200, 201, 250, 280, 299]
        let invalidJSON = Data("invalid json".utf8)

        try samples.forEach { code in
            XCTAssertThrowsError(
                try PokeItemMapper.map(invalidJSON, from: HTTPURLResponse(statusCode: code))
            )
        }
    }

    func test_deliverErrorOn200HTTPResponseWithInvalidData() {
        let invalidData = Data("invalidData".utf8)
        
        XCTAssertThrowsError(
            try PokeItemMapper.map(invalidData, from: HTTPURLResponse(statusCode: 200))
        )
    }

    func test_deliverNoItemsOn200HTTPResponseWithEmptyJSON() throws {

        let emptyListJSON = makeItemsJSONFromItems([])
        let result = try PokeItemMapper.map(emptyListJSON, from: HTTPURLResponse(statusCode: 200))
        XCTAssertEqual(result, [])
    }

    func test_load_deliversItemsOn200HTTPResponseWithJSONItems() throws {

        let pokeItem1 = makePokeItem(
            name: "Pikachu",
            url: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/25.png")

        let pokeItem2 = makePokeItem(
            name: "Clefairy",
            url: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/35.png")

        let items = [pokeItem1.model, pokeItem2.model]
        let json = makeItemsJSONFromItems(items)

        let result = try PokeItemMapper.map(json, from: HTTPURLResponse(statusCode: 200))
        XCTAssertEqual(result, items)
    }

    // MARK: Helpers

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
