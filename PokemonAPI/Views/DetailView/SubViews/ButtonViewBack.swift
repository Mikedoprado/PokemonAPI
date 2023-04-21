//
//  ButtonViewBack.swift
//  PokemonAPI
//
//  Created by Michael Conchado on 17/04/23.
//

import SwiftUI


struct ButtonViewBack: View {
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 50, height:50)
                .foregroundColor(.white)
            Image(systemName: "arrow.left")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 20, height:20)
                .foregroundColor(.pink)
        }
    }
}

struct ButtonViewBack_Previews: PreviewProvider {
    static var previews: some View {
        ButtonViewBack()
    }
}
