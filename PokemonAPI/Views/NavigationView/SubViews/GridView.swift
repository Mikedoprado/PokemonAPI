//
//  GridView.swift
//  PokemonAPI
//
//  Created by Michael Conchado on 16/04/23.
//

import SwiftUI

struct GridView: View {

    @Binding var isLandscape: Bool
    var list: [PokemonViewModel]
    
    var body: some View {
        LazyVGrid(columns: setColumns()) {
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
    
    private func setColumns() -> [GridItem] {
        if isLandscape {
            return [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
        } else {
            return [GridItem(.flexible()), GridItem(.flexible())]
        }
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView(isLandscape: .constant(false), list: [])
    }
}
