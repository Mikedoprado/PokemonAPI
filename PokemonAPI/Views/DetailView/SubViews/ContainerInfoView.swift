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
    let count: String
    
    init(title: String,count: String = "", @ViewBuilder content: () -> Content) {
        self.content = content()
        self.title = title
        self.count = count
    }
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 20)
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
            VStack(alignment: .leading) {
                HStack {
                    Text(title)
                        .modifier(CustomFontModifier(size: .subtitle, weight: .bold))
                        .foregroundColor(.gray)
                        .padding(.leading, 20)
                    Spacer()
                    Text(count)
                        .modifier(CustomFontModifier(size: .subtitle, weight: .bold))
                        .foregroundColor(.gray)
                        .padding(.trailing, 20)
                }
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
