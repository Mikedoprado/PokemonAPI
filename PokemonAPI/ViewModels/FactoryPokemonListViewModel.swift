//
//  FactoryPokemonListViewModel.swift
//  PokemonAPI
//
//  Created by Michael Conchado on 19/04/23.
//

import Foundation

final class FactoryPokemonListViewModel {
    private let session = URLSession(configuration: .ephemeral)
    private lazy var client = URLSessionHTTPClient(session: session)
    private lazy var pokeItemListLoader = PokeItemsLoader(client: client)
    private lazy var pokemonLoader = PokemonLoader(client: client)
    
    func makeViewModel() -> PokemonListViewModel {
        return PokemonListViewModel(
            service: PokemonService(
                pokeListLoader: pokeItemListLoader,
                pokemonListloader: pokemonLoader)
        )
    }
}
