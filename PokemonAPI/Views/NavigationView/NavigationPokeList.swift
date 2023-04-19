//
//  NavigationPokeList.swift
//  PokemonAPI
//
//  Created by Michael Conchado on 16/04/23.
//

import SwiftUI

struct NavigationPokeList: View {
    
    var list: [Pokemon]
    var filter: [Pokemon] = []
    @Binding var textfieldSearch: String
    @State var isSearching: Bool = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                SearchTextfieldView(textfieldSearch: $textfieldSearch)
                ScrollView {
                    GridView(list: list)
                }
                .background(PokeColor.dark.color)
                .navigationTitle("Pokedex")
                .navigationBarTitleDisplayMode(.inline)
                .toolbarColorScheme(.dark, for: .navigationBar)
                .toolbarBackground(.pink, for: .navigationBar)
                .toolbarBackground(.visible, for: .navigationBar)
            }
        }
    }
}

struct NavigationPokeList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationPokeList(list: [], textfieldSearch: .constant(""))
    }
}
