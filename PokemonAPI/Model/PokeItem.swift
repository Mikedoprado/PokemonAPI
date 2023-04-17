//
//  PokeItem.swift
//  PokemonAPI
//
//  Created by Michael Conchado on 16/04/23.
//

import Foundation

struct PokeItem {
    var name: String
    var url: String
}

struct ListPokeItems {
    let results: [PokeItem]
}
