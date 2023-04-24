//
//  ComposerPokemonList.swift
//  PokemonAPI
//
//  Created by Michael Conchado on 21/04/23.
//

import SwiftUI

struct ComposerPokemonList {
    @ObservedObject var deviceOrientationViewModel: DeviceOrientationViewModel
    @ObservedObject var pokelistViewModel: ListPokemonViewModel
    
    func compose() -> NavigationPokeList {
        NavigationPokeList(
            list: pokelistViewModel.pokeList,
            textfieldSearch: $pokelistViewModel.textSearching,
            isLoading: $pokelistViewModel.isLoading,
            invalidSearch: $pokelistViewModel.invalidSearch,
            connectivity: $pokelistViewModel.connectivity,
            isLandscape: $deviceOrientationViewModel.isLandscape,
            filterBy: $pokelistViewModel.filterBy
        )
    }
}
