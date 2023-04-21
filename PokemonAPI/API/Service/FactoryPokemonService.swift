//
//  FactoryPokemonService.swift
//  PokemonAPI
//
//  Created by Michael Conchado on 21/04/23.
//

import Foundation

final class FactoryPokemonService {
    private let session = URLSession(configuration: .ephemeral)
    private lazy var client = URLSessionHTTPClient(session: session)
    private lazy var pokeItemListLoader = PokeItemsLoader(client: client)
    private lazy var pokemonLoader = PokemonLoader(client: client)
    private let localDBPokemon = LocalDBPokemon()
    
    func makePokemonService() -> PokemonService {
        return PokemonService(
            pokeListLoader: pokeItemListLoader,
            pokemonListloader: pokemonLoader,
            localDBPokemon: localDBPokemon)
    }
}
