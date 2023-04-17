//
//  PokemonTypeIconView.swift
//  PokemonAPI
//
//  Created by Michael Conchado on 17/04/23.
//

import SwiftUI

struct PokemonTypeIconView: View {
    var icon: String
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(.white)
            Image(icon)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(5)
        }
        .frame(width: 30, height: 30)
    }
}

struct PokemonTypeIconView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonTypeIconView(icon: "grass")
    }
}
