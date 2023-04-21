//
//  GridView.swift
//  PokemonAPI
//
//  Created by Michael Conchado on 16/04/23.
//

import SwiftUI

struct GridView: View {
    
    @StateObject var viewModel: DeviceOrientationViewModel
    var list: [Pokemon]
    
    var body: some View {
        LazyVGrid(columns: viewModel.setColumns()) {
            ForEach(list, id: \.id) { pokemon in
                NavigationLink(
                    destination: PokemonDetail(
                        types: pokemon.types ?? [],
                        abilities: pokemon.abilities ?? [],
                        moves: pokemon.moves ?? [],
                        name: pokemon.name ?? "",
                        image: pokemon.artwork ?? pokemon.sprites ?? "")
                ) {
                    PokeItemView(
                        name: pokemon.name ?? "",
                        type: pokemon.types ?? [],
                        pokemonImage: pokemon.sprites ?? "")
                }
            }
        }
        .padding(10)
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView(viewModel: DeviceOrientationViewModel(), list: [])
    }
}
