//
//  PokeItem.swift
//  PokemonAPI
//
//  Created by Michael Conchado on 16/04/23.
//

import SwiftUI
import SDWebImageSwiftUI

struct PokeItemView: View {
    var name: String
    var type: [String]
    var pokemonImage: String
    
    var body: some View {
        VStack(alignment: .leading) {
            PokemonImage(pokemonImage: pokemonImage)
            VStack(alignment: .leading, spacing: 8) {
                Text(name.capitalized)
                    .modifier(CustomFontModifier(size: .caption))
                    .fontWeight(.regular)
                    .foregroundColor(PokeColor.dragon.color)
                HStack(spacing: 10) {
                    ForEach(type, id: \.self) { type in
                        ZStack(alignment: .center) {
                            Circle()
                                .foregroundColor(PokeColor(rawValue: type.lowercased())?.color)
                            PokemonTypeIconView(icon: type.lowercased(), size: 20)
                        }
                        .frame(width: 30, height: 30)
                    }
                }
            }.padding(.horizontal, 10)
        }
        .padding(10)
        .background(.white)
        .cornerRadius(20)
    }
}

struct PokeItem_Previews: PreviewProvider {
    static var previews: some View {
        PokeItemView(name: "Bulbasaur", type: ["Grass"], pokemonImage: "")
    }
}
