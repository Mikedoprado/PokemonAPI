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
    @StateObject var viewModel: DeviceOrientationViewModel
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                SearchTextfieldView(textfieldSearch: $textfieldSearch)
                ScrollView {
                    GridView(viewModel: viewModel, list: list)
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
        NavigationPokeList(
            list: [],
            textfieldSearch: .constant(""),
            viewModel: DeviceOrientationViewModel())
    }
}
