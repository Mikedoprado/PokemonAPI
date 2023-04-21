//
//  CustomTabBarView.swift
//  PokemonAPI
//
//  Created by Michael Conchado on 21/04/23.
//

import SwiftUI

struct CustomTabBarView: View {
    
    let tabs: [TabBarItem]
    @Binding var selection : TabBarItem
    @Namespace private var namespace
    
    var body: some View {
        HStack {
            ForEach(tabs, id: \.self) { tab in
                tabView(tab: tab)
                    .onTapGesture {
                        withAnimation(.easeInOut) {
                            switchToTab(tab: tab)
                        }
                    }
            }
        }
        .padding(10)
        
    }
}

extension CustomTabBarView {
    private func tabView(tab: TabBarItem) -> some View {
        ZStack {
            if selection == tab {
                RoundedRectangle(cornerRadius: 15)
                    .frame(height: 30)
                    .foregroundColor(PokeColor.dark.color)
                    .opacity(0.2)
                    .matchedGeometryEffect(id: "selection", in: namespace)
            }
            Text(tab.title.capitalized)
                .modifier(CustomFontModifier(size: .subtitle))
                .foregroundColor(.white)
                
        }
        .frame(maxWidth: .infinity)
        .padding(10)

    }
    
    private func switchToTab(tab: TabBarItem) {
        selection = tab
    }
    
}
