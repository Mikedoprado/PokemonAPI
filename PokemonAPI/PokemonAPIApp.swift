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
    @ObservedObject var deviceOrientationViewModel = DeviceOrientationViewModel()
    @ObservedObject var pokelistViewModel = ListPokemonViewModelFactory().makeViewModel()
    @State var isLaunching = true
    
    var body: some Scene {
        WindowGroup {
            if isLaunching {
                LaunchScreenView()
                    .onAppear { launching() }
            } else {
                ComposerPokemonList(
                    deviceOrientationViewModel: deviceOrientationViewModel,
                    pokelistViewModel: pokelistViewModel)
                .compose()
            }
        }
    }
    
    private func launching() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            isLaunching = false
        }
    }
}
