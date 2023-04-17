//
//  CustomFontModifier.swift
//  PokemonAPI
//
//  Created by Michael Conchado on 17/04/23.
//

import SwiftUI

struct CustomFontModifier: ViewModifier {
    var size: FontSize
    enum FontSize: CGFloat {
        case bigtitle = 28
        case title = 20
        case subtitle = 14
        case body = 16
        case caption = 12
    }
    func body(content: Content) -> some View {
        content.font(.custom("pixelmix", size: size.rawValue))
    }
}
