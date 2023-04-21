//
//  PokeItemMapper.swift
//  PokemonAPI
//
//  Created by Michael Conchado on 18/04/23.
//

import Foundation

struct PokeItemMapper {
    
    private static var OK_200: Int { 200 }
    
    static func map(_ data: Data, from response: HTTPURLResponse) throws -> [PokeItem] {
        guard
            response.statusCode == OK_200,
            let listPokeItems = try? JSONDecoder().decode(ListPokeItems.self, from: data)
        else { throw Loader<[PokeItem]>.Error.invalidData }
        let pokemons = listPokeItems.pokemon.map { $0.map { $0.pokemon } }
        return  listPokeItems.results ?? pokemons ?? []
    }

}
