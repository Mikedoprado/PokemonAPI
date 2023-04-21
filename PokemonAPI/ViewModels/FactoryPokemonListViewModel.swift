//
//  FactoryPokemonListViewModel.swift
//  PokemonAPI
//
//  Created by Michael Conchado on 19/04/23.
//

enum FactoryPokemonListViewModel {
    static func makeViewModel() -> PokemonListViewModel {
        return PokemonListViewModel(service: FactoryPokemonService().makePokemonService())
    }
}
