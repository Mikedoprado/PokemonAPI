//
//  NavigationPokeList.swift
//  PokemonAPI
//
//  Created by Michael Conchado on 16/04/23.
//

import SwiftUI

struct NavigationPokeList: View {
    var list: [PokemonViewModel]
    @State var isSearching: Bool = false
    @Binding var textfieldSearch: String
    @Binding var isLoading: Bool
    @Binding var invalidSearch: Bool
    @Binding var connectivity: Bool
    @Binding var isLandscape: Bool
    @Binding var filterBy: FilterTabItem
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                if isSearching {
                    SearchTextfieldView(
                        textfieldSearch: $textfieldSearch,
                        invalidSearch: $invalidSearch,
                        connectivity: $connectivity,
                        filterBy: $filterBy)
                }
                ZStack {
                    ScrollView {
                        GridView(isLandscape: $isLandscape, list: list)
                    }
                    .toolbar(content: {
                        searchButton
                    })
                    .background(PokeColor.dark.color)
                    .navigationTitle("Pokedex")
                    .navigationBarTitleDisplayMode(.large)
                    .toolbarColorScheme(.dark, for: .navigationBar)
                    .toolbarBackground(.pink, for: .navigationBar)
                    .toolbarBackground(.visible, for: .navigationBar)
                    if isLoading {
                        LoadingView(isLoading: $isLoading)
                    }
                }
            }
        }
    }
    
    private var searchButton: some View {
        Button(action: {
            withAnimation {
                isSearching.toggle()
            }
        }) {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.white)
        }
    }
}

struct NavigationPokeList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationPokeList(
            list: [],
            textfieldSearch: .constant(""),
            isLoading: .constant(true),
            invalidSearch: .constant(false),
            connectivity: .constant(true),
            isLandscape: .constant(false),
            filterBy: .constant(.name))
    }
}
