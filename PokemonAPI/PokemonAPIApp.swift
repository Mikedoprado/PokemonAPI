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
    let persistenceController = PersistenceController.shared
    @StateObject var viewModel = FactoryPokemonListViewModel().makeViewModel()
    @StateObject var deviceOrientationViewModel = DeviceOrientationViewModel()

    var body: some Scene {
        WindowGroup {
            NavigationPokeList(
                list: viewModel.pokeList,
                textfieldSearch: $viewModel.textSearching,
                viewModel: deviceOrientationViewModel
            ).environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
