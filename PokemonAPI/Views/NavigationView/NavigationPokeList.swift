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
    @Binding var loadMore: Bool
    
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
                    CustomScrollView(
                        loadMore: $loadMore,
                        isSearching: $isSearching,
                        isLandscape: $isLandscape) {
                            GridView(isLandscape: $isLandscape, list: list)
                        }
                    if isLoading {
                        LoadingView(isLoading: $isLoading)
                    }
                }
            }
            .background(Color.pink)
        }
    }
}

struct NavigationPokeList_Previews: PreviewProvider {
    static var previews: some View {
        NavigationPokeList(
            list: [],
            textfieldSearch: .constant(""),
            isLoading: .constant(false),
            invalidSearch: .constant(false),
            connectivity: .constant(true),
            isLandscape: .constant(false),
            filterBy: .constant(.name),
            loadMore: .constant(false))
    }
}
