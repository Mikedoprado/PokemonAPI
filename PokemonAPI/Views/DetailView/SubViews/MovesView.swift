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
        ContainerInfoView(title: title, count: "\(moves.count)") {
            ScrollView {
                ForEach(Array(moves.enumerated()), id: \.1) { (index, move) in
                    LazyVStack {
                        ZStack(alignment: .leading) {
                            RoundedRectangle(cornerRadius: 5)
                                .frame(height: 50)
                                .foregroundColor(PokeColor.white.color)
                            CharacteristicTextView(characteristic: move)
                                .padding(.leading, 20)
                        }
                    }
                }
            }.frame(height: 220)
        }
    }
}

struct MovesView_Previews: PreviewProvider {
    static var previews: some View {
        MovesView(moves: ["Razor wind", "Sword-Dance", "Cut", "Bind"], title: "Moves")
    }
}
