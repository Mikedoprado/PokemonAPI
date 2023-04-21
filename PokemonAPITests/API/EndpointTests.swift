//
//  EndpointTests.swift
//  PokemonAPITests
//
//  Created by Michael Conchado on 18/04/23.
//

import XCTest
@testable import PokemonAPI

final class EndpointTests: XCTestCase {
    
    func test_getpokeList_endpointURL() {
        let baseURL = URL(string: "http://base-url.com")!

        let received = Endpoint.getPokeList.url(baseURL: baseURL)
        let expected = URL(string: "http://base-url.com/v2/pokemon")!

        XCTAssertEqual(received, expected)
    }
    
    func test_getPokemonByName_endpointURL() {
        let baseURL = URL(string: "http://base-url.com")!

        let pokemonName = "bulbasaur"
        let received = Endpoint.getPokemonByName(pokemonName).url(baseURL: baseURL)
        let expected = URL(string: "http://base-url.com/v2/pokemon/\(pokemonName)")!

        XCTAssertEqual(received, expected)
    }
    
    func test_getPokemonByType_endpointURL() {
        let baseURL = URL(string: "http://base-url.com")!

        let pokemonType = "grass"
        let received = Endpoint.getPokemonByType(pokemonType).url(baseURL: baseURL)
        let expected = URL(string: "http://base-url.com/v2/type/\(pokemonType)")!

        XCTAssertEqual(received, expected)
    }
}
