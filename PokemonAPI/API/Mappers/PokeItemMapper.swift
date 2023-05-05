//
//  PokeItemMapper.swift
//  PokemonAPI
//
//  Created by Michael Conchado on 18/04/23.
//

import Foundation

struct PokeItemMapper {
    
    private static var OK_200: Int { 200 }
    
    private enum Error: Swift.Error {
        case invalidData
    }
    
    static func map(_ data: Data, from response: HTTPURLResponse) throws -> [PokeItem] {
        guard
            response.statusCode == OK_200,
            let listPokeItems = try? JSONDecoder().decode(ListPokeItems.self, from: data)
        else { throw Error.invalidData }
        let pokemons = listPokeItems.pokemon.map { $0.map { $0.pokemon } }
        return  listPokeItems.results ?? pokemons ?? []
    }

}

struct PokeListMapper {
    
    private static var OK_200: Int { 200 }
    
    private enum Error: Swift.Error {
        case invalidData
    }
    
    static func map(_ data: Data, from response: HTTPURLResponse) throws -> ListPokeItems {
        guard
            response.statusCode == OK_200,
            let listPokeItems = try? JSONDecoder().decode(ListPokeItems.self, from: data)
        else { throw Error.invalidData }
        return  listPokeItems
    }

}
