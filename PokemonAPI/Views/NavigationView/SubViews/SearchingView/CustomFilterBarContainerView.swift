//
//  CustomTabBarContainerView.swift
//  PokemonAPI
//
//  Created by Michael Conchado on 21/04/23.
//

import SwiftUI

struct CustomFilterBarContainerView<Content:View>: View {
    
    @Binding var selection: FilterTabItem
    @State private var tabs: [FilterTabItem] = []
    let content : Content
    
    init(selection: Binding<FilterTabItem>, @ViewBuilder content: () -> Content) {
        self._selection = selection
        self.content = content()
    }
    var body: some View {
        ZStack(alignment: .bottom) {
            content
                .ignoresSafeArea()
            
            CustomFilterBarView(tabs: tabs, selection: $selection)
        }
        .onPreferenceChange(FilterBarItemsPreferenceKey.self) { value in
            self.tabs = value
        }
    }
}
