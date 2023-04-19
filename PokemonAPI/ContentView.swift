//
//  ContentView.swift
//  PokemonAPI
//
//  Created by Michael Conchado on 15/04/23.
//

import SwiftUI

struct ContentView: View {

    @StateObject var viewModel = FactoryPokemonListViewModel().makeViewModel()

    var body: some View {
        NavigationPokeList(list: viewModel.pokeList)
            .onAppear {
                viewModel.fetchPokemons()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


