//
//  PokemonImage.swift
//  PokemonAPI
//
//  Created by Michael Conchado on 17/04/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct PokemonImage: View {
    var pokemonImage: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .frame(maxWidth: .infinity)
                .foregroundColor(PokeColor.white.color)
            WebImage(url: URL(string: pokemonImage))
                .resizable()
                .placeholder(Image("notFound"))
                .indicator(.activity)
                .aspectRatio(contentMode: .fit)
        }
    }
}

struct PokemonImage_Previews: PreviewProvider {
    static var previews: some View {
        PokemonImage(pokemonImage: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png")
    }
}
