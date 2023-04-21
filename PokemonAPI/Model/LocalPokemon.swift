//
//  LocalPokemon.swift
//  PokemonAPI
//
//  Created by Michael Conchado on 20/04/23.
//

import Foundation

struct LocalPokemon: Codable {
    let id: Int
    let name: String?
    let types: [String]?
    let abilities: [String]?
    let sprites: String?
    let moves: [String]?
    let artwork: String?
}
