//
//  SearchingFilterView.swift
//  PokemonAPI
//
//  Created by Michael Conchado on 21/04/23.
//

import SwiftUI

struct SearchingFilterView: View {
    var tabBarItems: [FilterTabItem] = [.name, .type, .ability]
    @Binding var selection: FilterTabItem
    var body: some View {
        HStack {
            CustomFilterBarView(tabs: tabBarItems, selection: $selection)
        }
    }
}

struct SearchingFilterView_Previews: PreviewProvider {
    static var previews: some View {
        SearchingFilterView(selection: .constant(.name))
    }
}






