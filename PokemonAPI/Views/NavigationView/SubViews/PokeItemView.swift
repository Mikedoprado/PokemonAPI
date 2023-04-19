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
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .frame(maxWidth: .infinity)
                    .frame(height: 150)
                    .foregroundColor(PokeColor.white.color)
                    .padding(.bottom, 0)
                WebImage(url: URL(string: pokemonImage))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            VStack(alignment: .leading, spacing: 8) {
                Text(name.capitalized)
                    .modifier(CustomFontModifier(size: .caption))
                    .fontWeight(.regular)
                    .foregroundColor(.gray)
                HStack(spacing: 10) {
                    ForEach(type, id: \.self) { type in
                        ZStack(alignment: .center) {
                            Circle()
                                .foregroundColor(PokeColor(rawValue: type.lowercased())?.color)
                            PokemonTypeIconView(icon: type.lowercased())
//                            Text(type.capitalized)
//                                .modifier(CustomFontModifier(size: .caption))
//                                .fontWeight(.regular)
//                                .foregroundColor(.white)
//                                .padding(.vertical, 3)
                        }.frame(width: 40, height: 40)
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
