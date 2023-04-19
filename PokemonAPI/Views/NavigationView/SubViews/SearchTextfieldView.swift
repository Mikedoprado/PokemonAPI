//
//  SearchTextfieldView.swift
//  PokemonAPI
//
//  Created by Michael Conchado on 19/04/23.
//

import SwiftUI

struct SearchTextfieldView: View {
    @Binding var textfieldSearch: String
    
    var body: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.white)
                    .frame(height: 40)
                TextField("Search", text: $textfieldSearch)
                    .frame(height: 40)
                    .foregroundColor(PokeColor.dragon.color)
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding(20)
            }.padding(.horizontal, 20)
        }.background(Color.pink)
    }
}

struct SearchTextfieldView_Previews: PreviewProvider {
    static var previews: some View {
        SearchTextfieldView(textfieldSearch: .constant(""))
    }
}
