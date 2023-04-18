//
//  ScrollViewNavigationAppereance.swift
//  PokemonAPI
//
//  Created by Michael Conchado on 18/04/23.
//

import SwiftUI

struct ScrollViewNavigationAppearance<Content:View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    var body: some View {
        ScrollView {
            content
                .padding(.horizontal, 20)
                .padding(.top, 20)
        }
        .frame(maxWidth: .infinity)
        .background(Color.black)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .toolbarBackground(.pink, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
}

struct ScrollViewNavigationAppereance_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewNavigationAppearance(content: {})
    }
}
