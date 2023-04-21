//
//  LocalPokemonMapper.swift
//  PokemonAPI
//
//  Created by Michael Conchado on 20/04/23.
//

import Foundation

enum LocalPokemonMapper {
    static func map(localPokemon: LocalPokemon) -> Pokemon {
        Pokemon(
            id: localPokemon.id,
            name: localPokemon.name,
            types: localPokemon.types,
            abilities: localPokemon.abilities,
            sprites: localPokemon.sprites,
            moves: localPokemon.moves,
            artwork: localPokemon.artwork)
    }
}
