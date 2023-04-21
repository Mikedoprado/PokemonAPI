//
//  NavigationPokeList.swift
//  PokemonAPI
//
//  Created by Michael Conchado on 16/04/23.
//

import SwiftUI

struct NavigationPokeList: View {
    var list: [Pokemon]
    @Binding var textfieldSearch: String
    @Binding var isLoading: Bool
    @State var isSearching: Bool = false
    @StateObject var viewModel: DeviceOrientationViewModel
    @Binding var invalidSearch: Bool
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                if isSearching {
                    SearchTextfieldView(textfieldSearch: $textfieldSearch, invalidSearch: $invalidSearch)
                }
                ZStack {
                    ScrollView {
                        GridView(viewModel: viewModel, list: list)
                    }
                    .toolbar(content: {
                        Button(action: {isSearching.toggle()}) {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.white)
                        }
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
}

struct NavigationPokeList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationPokeList(
            list: [],
            textfieldSearch: .constant(""),
            isLoading: .constant(true),
            viewModel: DeviceOrientationViewModel(),
            invalidSearch: .constant(false))
    }
}
