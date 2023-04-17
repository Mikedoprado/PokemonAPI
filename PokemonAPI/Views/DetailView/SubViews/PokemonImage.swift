//
//  PokemonImage.swift
//  PokemonAPI
//
//  Created by Michael Conchado on 17/04/23.
//

import SwiftUI

struct PokemonImage: View {
    var pokemonImage: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .frame(maxWidth: .infinity)
                .frame(height: 300)
                .foregroundColor(.white)
            Image(systemName: pokemonImage)
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.pink)
        }
    }
}

struct PokemonImage_Previews: PreviewProvider {
    static var previews: some View {
        PokemonImage(pokemonImage: "person")
    }
}
