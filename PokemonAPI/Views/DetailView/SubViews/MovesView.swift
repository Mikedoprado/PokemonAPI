//
//  MovesView.swift
//  PokemonAPI
//
//  Created by Michael Conchado on 17/04/23.
//

import SwiftUI

struct MovesView: View {
    var moves: [String]
    var title: String
    var body: some View {
        ContainerInfoView(title: title) {
            ForEach(Array(moves.enumerated()), id: \.1) { (index, move) in
                if index < 9 {
                    VStack {
                        Text(move.capitalized)
                            .modifier(CustomFontModifier(size: .body))
                            .foregroundColor(PokeColor.dragon.color)
                            .padding(.bottom, 5)
                    }
                }
            }
            if moves.count > 9 {
                Text("...")
                    .modifier(CustomFontModifier(size: .body))
                    .foregroundColor(PokeColor.dragon.color)
            }
        }
    }
}

struct MovesView_Previews: PreviewProvider {
    static var previews: some View {
        MovesView(moves: ["Razor wind", "Sword-Dance", "Cut", "Bind"], title: "Moves")
    }
}
