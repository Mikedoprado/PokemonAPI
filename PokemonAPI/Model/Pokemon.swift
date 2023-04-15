//
//  Pokemon.swift
//  PokemonAPI
//
//  Created by Michael Conchado on 15/04/23.
//

import Foundation

struct Pokemon {
    let id: Int
    let name: String
    let types: [Kind]
    let abilities: [Ability]
    let sprites: URL
    let moves: [Move]
}
