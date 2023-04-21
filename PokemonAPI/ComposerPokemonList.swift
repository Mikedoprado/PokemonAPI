//
//  ComposerPokemonList.swift
//  PokemonAPI
//
//  Created by Michael Conchado on 21/04/23.
//

import SwiftUI

struct ComposerPokemonList {
    @ObservedObject var pokemonListViewModel: PokemonListViewModel
    @ObservedObject var deviceOrientationViewModel: DeviceOrientationViewModel
    
    func compose() -> NavigationPokeList {
        NavigationPokeList(
            list: pokemonListViewModel.pokeList,
            textfieldSearch: $pokemonListViewModel.textSearching,
            isLoading: $pokemonListViewModel.isLoading,
            invalidSearch: $pokemonListViewModel.invalidSearch,
            connectivity: $pokemonListViewModel.connectivity,
            isLandscape: $deviceOrientationViewModel.isLandscape
        )
    }
}
