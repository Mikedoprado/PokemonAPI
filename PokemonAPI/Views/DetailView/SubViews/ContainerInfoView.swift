//
//  ContainerInfoView.swift
//  PokemonAPI
//
//  Created by Michael Conchado on 17/04/23.
//

import SwiftUI

struct ContainerInfoView<Content:View>: View {
    
    let content: Content
    let title: String
    
    init(title: String, @ViewBuilder content: () -> Content) {
        self.content = content()
        self.title = title
    }
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 20)
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
            VStack(alignment: .leading) {
                Text(title)
                    .modifier(CustomFontModifier(size: .subtitle, weight: .bold))
                    .foregroundColor(.gray)
                    .padding(.leading, 20)
                    .padding(.top, 20)
                    .padding(.bottom, 10)
                content
                    .padding(.horizontal, 20)
            }.padding(.bottom, 20)
        }
    }
}

struct ContainerInfoView_Previews: PreviewProvider {
    static var previews: some View {
        ContainerInfoView(title: "", content: {  })
    }
}
