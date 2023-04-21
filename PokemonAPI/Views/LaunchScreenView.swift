//
//  LaunchScreenView.swift
//  PokemonAPI
//
//  Created by Michael Conchado on 21/04/23.
//

import SwiftUI

struct LaunchScreenView: View {
    var body: some View {
        ZStack {
            Color.pink
            VStack {
                ZStack {
                    Circle()
                        .foregroundColor(.white)
                        .frame(width: 150, height: 150)
                    Image("pokebola")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                }
                .padding(.bottom, 20)
                Text("PokemonApp")
                    .modifier(CustomFontModifier(size: .bigtitle))
                    .foregroundColor(.white)
            }
        }
        .ignoresSafeArea()
    }
}

struct LaunchScreenView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchScreenView()
    }
}
