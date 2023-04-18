//
//  PokeItem.swift
//  PokemonAPI
//
//  Created by Michael Conchado on 16/04/23.
//

import Foundation

struct PokeItem: Codable, Equatable {
    var name: String
    var url: String
}

struct ListPokeItems: Codable {
    let results: [PokeItem]
}

struct PokeItemMapper {
    
    private static var OK_200: Int { 200 }
    
    static func map(_ data: Data, from response: HTTPURLResponse) throws -> [PokeItem] {
        guard
            response.statusCode == OK_200,
            let listPokeItems = try? JSONDecoder().decode(ListPokeItems.self, from: data)
        else { throw Loader<[PokeItem]>.Error.invalidData }
        return  listPokeItems.results
    }

}
