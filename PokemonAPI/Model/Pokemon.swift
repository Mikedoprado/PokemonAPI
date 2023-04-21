//
//  Pokemon.swift
//  PokemonAPI
//
//  Created by Michael Conchado on 15/04/23.
//

import Foundation

struct Pokemon {
    let id: Int
    let name: String?
    let types: [String]?
    let abilities: [String]?
    let sprites: String?
    let moves: [String]?
    let artwork: String?
}

extension Pokemon: Equatable {
    static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        lhs.id == rhs.id
    }
}
