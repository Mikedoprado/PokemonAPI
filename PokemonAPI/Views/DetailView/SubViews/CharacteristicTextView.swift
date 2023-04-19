//
//  CharacteristicTextView.swift
//  PokemonAPI
//
//  Created by Michael Conchado on 19/04/23.
//

import SwiftUI

struct CharacteristicTextView: View {
    var characteristic: String
    var body: some View {
        Text(characteristic.capitalized)
            .modifier(CustomFontModifier(size: .body))
            .foregroundColor(PokeColor.dragon.color)
            .padding(.trailing, 10)
            .padding(.bottom, 5)
    }
}

struct CharacteristicTextView_Previews: PreviewProvider {
    static var previews: some View {
        CharacteristicTextView(characteristic: "some text")
    }
}
