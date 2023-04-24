//
//  CustomTabBarView.swift
//  PokemonAPI
//
//  Created by Michael Conchado on 21/04/23.
//

import SwiftUI

struct CustomFilterBarView: View {
    
    let tabs: [FilterTabItem]
    @Binding var selection : FilterTabItem
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

extension CustomFilterBarView {
    private func tabView(tab: FilterTabItem) -> some View {
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
    
    private func switchToTab(tab: FilterTabItem) {
        selection = tab
    }
    
}
