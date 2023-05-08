//
//  FilterBarItemsPreferenceKey.swift
//  PokemonAPI
//
//  Created by Michael Conchado on 21/04/23.
//

import SwiftUI

struct FilterBarItemsPreferenceKey: PreferenceKey {
    static var defaultValue: [FilterTabItem] = []
    
    static func reduce(value: inout [FilterTabItem], nextValue: () -> [FilterTabItem]) {
        value += nextValue()
    }
}

struct FilterBarItemViewModifier: ViewModifier {
    
    let tab: FilterTabItem
    @Binding var selection: FilterTabItem
    
    func body(content: Content) -> some View {
        content
            .opacity(selection == tab ? 1.0 : 0.0)
            .preference(key: FilterBarItemsPreferenceKey.self, value: [tab])
    }
}

extension View {
    func tabBarItem(tab: FilterTabItem, selection: Binding<FilterTabItem>) -> some View {
        modifier(FilterBarItemViewModifier(tab: tab, selection: selection))
    }
}
