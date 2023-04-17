//
//  PokemonNameView.swift
//  PokemonAPI
//
//  Created by Michael Conchado on 17/04/23.
//

import SwiftUI

struct PokemonNameView: View {
    var name: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Name")
                .modifier(CustomFontModifier(size: .subtitle))
                .foregroundColor(.white)
            Text(name)
                .modifier(CustomFontModifier(size: .title))
                .foregroundColor(.white)
        }
    }
}

struct PokemonNameView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonNameView(name: "Bulbasaur")
    }
}
