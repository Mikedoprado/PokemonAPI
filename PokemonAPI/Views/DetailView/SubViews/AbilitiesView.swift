//
//  AbilitiesView.swift
//  PokemonAPI
//
//  Created by Michael Conchado on 17/04/23.
//

import SwiftUI

struct AbilitiesView: View {
    var abilities: [String]
    var title: String
    
    var body: some View {
        ContainerInfoView(title: title) {
            VStack(alignment: .leading, spacing: 10) {
                ForEach(abilities, id: \.self) { ability in
                    Text(ability.capitalized)
                        .modifier(CustomFontModifier(size: .body))
                        .foregroundColor(PokeColor.dragon.color)
                        .padding(.trailing, 10)
                }
            }
        }
    }
}

struct AbilitiesView_Previews: PreviewProvider {
    static var previews: some View {
        AbilitiesView(abilities: ["Overgrown" , "Chlorophyll"], title: "Abilities")
    }
}
