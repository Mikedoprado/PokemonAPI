//
//  ScrollViewNavigationAppereance.swift
//  PokemonAPI
//
//  Created by Michael Conchado on 18/04/23.
//

import SwiftUI

struct ScrollViewNavigationAppearance<Content:View>: View {
    let backgroundColor: Color
    let content: Content

    init(backgroundColor: Color, @ViewBuilder content: () -> Content) {
        self.backgroundColor = backgroundColor
        self.content = content()
    }
    var body: some View {
        ScrollView {
            content
                .padding(.horizontal, 20)
                .padding(.top, 20)
        }
        .frame(maxWidth: .infinity)
        .background(backgroundColor)
        .navigationBarTitleDisplayMode(.inline)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .toolbarBackground(backgroundColor, for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
    }
}

struct ScrollViewNavigationAppereance_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewNavigationAppearance(backgroundColor: Color.pink, content: {})
    }
}
