//
//  PokeItem.swift
//  PokemonAPI
//
//  Created by Michael Conchado on 16/04/23.
//

import Foundation

struct PokeItem: Codable {
    var name: String
    var url: String
}

struct ListPokeItems: Codable {
    let results: [PokeItem]
}
