//
//  LoadingView.swift
//  PokemonAPI
//
//  Created by Michael Conchado on 21/04/23.
//

import SwiftUI

struct LoadingView: View {
    @Binding var isLoading: Bool
    var body: some View {
        if isLoading {
            ZStack {
                Rectangle()
                    .foregroundColor(PokeColor.dark.color)
                    .opacity(0.8)
                    .ignoresSafeArea()
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .scaleEffect(2)
            }
        }
    }
}

struct LoadingView_Previews: PreviewProvider {
    static var previews: some View {
        LoadingView(isLoading: .constant(true))
    }
}
