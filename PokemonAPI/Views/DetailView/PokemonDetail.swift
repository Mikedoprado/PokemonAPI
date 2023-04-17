//
//  PokemonDetail.swift
//  PokemonAPI
//
//  Created by Michael Conchado on 16/04/23.
//

import SwiftUI

struct PokemonDetail: View {
    var types: [String]
    var abilities: [String]
    var moves: [String]
    var name: String
    var image: String = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png"
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                HStack {
                    PokemonNameView(name: name)
                    Spacer()
                    Button(action: {}) {
                        ButtonViewBack()
                    }
                }
                PokemonImage(pokemonImage: image)
                PokeTypeView(types: types, title: "Types")
                AbilitiesView(abilities: abilities, title: "Abilities")
                MovesView(moves: moves, title: "Moves")
            }
            .padding(.horizontal, 20)
        }
        .frame(maxWidth: .infinity)
        .background(Color.pink)
    }
}

struct PokemonDetail_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetail(
            types: ["grass", "water"],
            abilities: ["Overgrown" , "Chlorophyll"],
            moves: ["Razor wind", "Sword-Dance", "Cut", "Bind"],
            name: "Bulbasaur"
        )
    }
}
