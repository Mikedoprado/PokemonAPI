//
//  PokemonAPIApp.swift
//  PokemonAPI
//
//  Created by Michael Conchado on 15/04/23.
//

import SwiftUI

let baseURL = URL(string: "https://pokeapi.co/api")!

@main
struct PokemonAPIApp: App {
    @StateObject var pokemonListViewModel = FactoryPokemonListViewModel.makeViewModel()
    @StateObject var deviceOrientationViewModel = DeviceOrientationViewModel()
    @State var isLaunching = true
    
    var body: some Scene {
        WindowGroup {
            if isLaunching {
                LaunchScreenView()
                    .onAppear { launching() }
            } else {
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
    }
    
    private func launching() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            isLaunching = false
        }
    }
}
