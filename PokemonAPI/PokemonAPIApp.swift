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
    @StateObject var viewModel = FactoryPokemonListViewModel().makeViewModel()
    @StateObject var deviceOrientationViewModel = DeviceOrientationViewModel()
    @State var isLaunching = true
    
    var body: some Scene {
        WindowGroup {
            if isLaunching {
                LaunchScreenView()
                    .onAppear { launching() }
            } else {
                NavigationPokeList(
                    list: viewModel.pokeList,
                    textfieldSearch: $viewModel.textSearching,
                    isLoading: $viewModel.isLoading,
                    viewModel: deviceOrientationViewModel
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
