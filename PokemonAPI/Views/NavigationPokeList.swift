//
//  NavigationPokeList.swift
//  PokemonAPI
//
//  Created by Michael Conchado on 16/04/23.
//

import SwiftUI

struct NavigationPokeList: View {

    var list: [Pokemon]
    
    var body: some View {
        NavigationView {
            ScrollView {
                GridView(list: list)
            }
            .background(Color.black)
            .navigationTitle("Pokedex")
            .toolbar {
                Button(action: {}) {
                    HStack {
                        Text("Search")
                        Image(systemName: "magnifyingglass")
                    }
                }
            }
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(.pink, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
}

struct NavigationPokeList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationPokeList(list: list)
    }
}
