//
//  LoadMorePreferenceKey.swift
//  PokemonAPI
//
//  Created by Michael Conchado on 7/05/23.
//

import SwiftUI

struct LoadMorePreferenceKey: PreferenceKey {
    static var defaultValue: Bool = false
    
    static func reduce(value: inout Bool, nextValue: () -> Bool) {
        value = nextValue()
    }
}

struct LoadMoreViewModifier: ViewModifier {
    
    let isLoadingMore: Bool
    @Binding var loadMore: Bool
    
    func body(content: Content) -> some View {
        content
            .preference(key: LoadMorePreferenceKey.self, value: isLoadingMore)
    }
}

extension View {
    func listIsLoadingMore(loadMore: Bool, selection: Binding<Bool>) -> some View {
        modifier(LoadMoreViewModifier(isLoadingMore: loadMore, loadMore: selection))
    }
}
