//
//  PokeTypeView.swift
//  PokemonAPI
//
//  Created by Michael Conchado on 17/04/23.
//

import SwiftUI

struct PokeTypeView: View {
    var types: [String]
    var title: String
    
    var body: some View {
        ContainerInfoView(title: title) {
            HStack {
                ForEach(types, id: \.self) { type in
                    BadgeTypeView(type: type)
                }
            }
        }
    }
}

struct PokeTypeView_Previews: PreviewProvider {
    static var previews: some View {
        PokeTypeView(types: ["grass"], title: "Types")
    }
}
