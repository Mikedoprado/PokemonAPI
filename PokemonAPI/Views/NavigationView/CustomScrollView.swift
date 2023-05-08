//
//  CustomScrollView.swift
//  PokemonAPI
//
//  Created by Michael Conchado on 7/05/23.
//

import SwiftUI

struct CustomScrollView<Content:View>: View {
    @Binding var loadMore: Bool
    @Binding var isSearching: Bool
    @Binding var isLandscape: Bool
    private let content: Content
    private var cellHeight: CGFloat { isLandscape ? 2 : 3 }
    
    init(
        loadMore: Binding<Bool>,
        isSearching: Binding<Bool>,
        isLandscape: Binding<Bool>,
        @ViewBuilder content: () -> Content
    ) {
        self._loadMore = loadMore
        self._isSearching = isSearching
        self._isLandscape = isLandscape
        self.content = content()
    }
    
    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                content
                    .coordinateSpace(name: "scrollView")
                    .background(
                        GeometryReader { innerProxy -> Color in
                            loadingMore(proxy, innerProxy)
                        }
                    )
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
        }
        .onPreferenceChange(LoadMorePreferenceKey.self) { value in
            self.loadMore = value
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
    
    private func loadingMore(_ proxy: GeometryProxy, _ innerProxy: GeometryProxy) -> Color {
        let scrollViewProxy = proxy
            .frame(in: .named("scrollView"))
        let distance = innerProxy
            .frame(in: .named("scrollView"))
            .maxY - scrollViewProxy.maxY
        if distance < proxy.size.height / cellHeight {
            DispatchQueue.main.async {
                self.loadMore = true
            }
        } else {
            DispatchQueue.main.async {
                self.loadMore = false
            }
        }
        return Color.clear
    }
}

struct CustomScrollView_Previews: PreviewProvider {
    static var previews: some View {
        CustomScrollView(
            loadMore: .constant(false),
            isSearching: .constant(false),
            isLandscape: .constant(false),
            content: {})
    }
}
