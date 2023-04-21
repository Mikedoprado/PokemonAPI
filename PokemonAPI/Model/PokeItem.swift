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
    let results: [PokeItem]?
    let pokemon: ListPokemon?
}

struct ListPokemon: Codable {
    let pokemon: [PokeItem]
}
