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
                    .autocorrectionDisabled()
                    .frame(height: 40)
                    .foregroundColor(PokeColor.dragon.color)
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding(20)
                    .overlay(cleanButton)
                        
            }.padding(.horizontal, 20)
        }.background(Color.pink)
    }
    
    private var cleanButton: some View {
        Button(action: { self.textfieldSearch = "" }) {
            HStack {
                Spacer()
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(PokeColor.normal.color.opacity(0.5))
                    .opacity(textfieldSearch.isEmpty ? 0 : 1)
            }
        }
        .padding(.trailing, 10)
        .transition(.move(edge: .trailing))
    }
}

struct SearchTextfieldView_Previews: PreviewProvider {
    static var previews: some View {
        SearchTextfieldView(textfieldSearch: .constant(""))
    }
}
