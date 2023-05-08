//
//  ComposerPokemonList.swift
//  PokemonAPI
//
//  Created by Michael Conchado on 21/04/23.
//

import SwiftUI
import Combine

struct ComposerPokemonList {
    @ObservedObject var deviceOrientationViewModel: DeviceOrientationViewModel
    @ObservedObject var pokelistViewModel: ListPokemonViewModel
    
    func compose() -> NavigationPokeList {
        NavigationPokeList(
            list: pokelistViewModel.pokeList,
            textfieldSearch: $pokelistViewModel.appStates.textSearching,
            isLoading: $pokelistViewModel.appStates.isLoading,
            invalidSearch: $pokelistViewModel.appStates.invalidSearch,
            connectivity: $pokelistViewModel.appStates.connectivity,
            isLandscape: $deviceOrientationViewModel.isLandscape,
            filterBy: $pokelistViewModel.filterBy,
            loadMore: $pokelistViewModel.appStates.loadMore)
        
    }
}
