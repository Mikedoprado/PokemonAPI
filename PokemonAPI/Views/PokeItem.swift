//
//  PokeItem.swift
//  PokemonAPI
//
//  Created by Michael Conchado on 16/04/23.
//

import SwiftUI

struct PokeItem: View {
    var name: String
    var type: [String]
    
    var body: some View {
        VStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 20)
                .frame(maxWidth: .infinity)
                .frame(height: 150)
                .foregroundColor(.pink)
                .padding(.bottom, 0)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(name)
                    .font(.title2)
                    .fontWeight(.regular)
                    .foregroundColor(.gray)
                HStack(spacing: 10) {
                    ForEach(type, id: \.self) { type in
                        ZStack(alignment: .center) {
                            RoundedRectangle(cornerRadius: 20)
                                .foregroundColor(.gray)
                            Text(type)
                                .font(.body)
                                .fontWeight(.regular)
                                .foregroundColor(.white)
                                .padding(.vertical, 2)
                        }
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
        PokeItem(name: "Bulbasaur", type: ["Grass"])
    }
}
