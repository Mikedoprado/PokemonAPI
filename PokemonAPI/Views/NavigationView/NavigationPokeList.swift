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
    @StateObject var viewModel: DeviceOrientationViewModel
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                SearchTextfieldView(textfieldSearch: $textfieldSearch)
                ZStack {
                    ScrollView {
                        GridView(viewModel: viewModel, list: list)
                    }
                    .background(PokeColor.dark.color)
                    .navigationTitle("Pokedex")
                    .navigationBarTitleDisplayMode(.inline)
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
            viewModel: DeviceOrientationViewModel())
    }
}

struct LoadingView: View {
    @Binding var isLoading: Bool
    var body: some View {
        if isLoading {
            ZStack {
                Rectangle()
                    .foregroundColor(PokeColor.dark.color)
                    .opacity(0.8)
                    .ignoresSafeArea()
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(2)
            }
        }
    }
}
