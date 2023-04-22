//
//  PokemonViewModel.swift
//  PokemonAPI
//
//  Created by Michael Conchado on 22/04/23.
//

import Foundation

struct PokemonViewModel {

    private let pokemon: Pokemon
    
    init(_ pokemon: Pokemon) {
        self.pokemon = pokemon
    }
    
    var id: Int { pokemon.id }
    var name: String { pokemon.name ?? "Unknown" }
    var types: [String] { pokemon.types ?? [] }
    var moves: [String] { pokemon.moves ?? [] }
    var abilities: [String] { pokemon.abilities ?? [] }
    var sprites: String { pokemon.sprites ?? "" }
    var artwork: String { pokemon.artwork ?? "" }
    
}
