//
//  BadgeTypeView.swift
//  PokemonAPI
//
//  Created by Michael Conchado on 17/04/23.
//

import SwiftUI

struct BadgeTypeView: View {
    var type: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 25)
                .foregroundColor(PokeColor(rawValue: type.lowercased())?.color)
            HStack {
                PokemonTypeIconView(icon: type.lowercased(), size: 30)
                    .padding(.vertical, 8)
                    .padding(.leading, 8)
                Text(type.capitalized)
                    .modifier(CustomFontModifier(size: .subtitle))
                    .foregroundColor(.white)
                    .padding(.trailing, 10)
            }
        }
    }
}

struct BadgeTypeView_Previews: PreviewProvider {
    static var previews: some View {
        BadgeTypeView(type: "grass")
    }
}
