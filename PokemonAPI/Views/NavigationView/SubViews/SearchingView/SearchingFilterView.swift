//
//  SearchingFilterView.swift
//  PokemonAPI
//
//  Created by Michael Conchado on 21/04/23.
//

import SwiftUI

struct SearchingFilterView: View {
    var tabBarItems: [TabBarItem] = [.name, .type, .ability]
    @Binding var selection: TabBarItem
    var body: some View {
        HStack {
            CustomTabBarView(tabs: tabBarItems, selection: $selection)
        }
    }
}

struct SearchingFilterView_Previews: PreviewProvider {
    static var previews: some View {
        SearchingFilterView(selection: .constant(.name))
    }
}






