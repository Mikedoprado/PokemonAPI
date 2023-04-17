//
//  PokemonDetail.swift
//  PokemonAPI
//
//  Created by Michael Conchado on 16/04/23.
//

import SwiftUI

struct PokemonDetail: View {
    var types: [String]
    var abilities: [String]
    var moves: [String]
    var name: String
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                HStack {
                    PokemonNameView(name: name)
                    Spacer()
                    Button(action: {}) {
                        ButtonViewBack()
                    }
                }
                PokemonImage(pokemonImage: "person")
                PokeTypeView(types: types, title: "Types")
                AbilitiesView(abilities: abilities, title: "Abilities")
                MovesView(moves: moves, title: "Moves")
            }
            .padding(.horizontal, 20)
        }
        .frame(maxWidth: .infinity)
        .background(Color.pink)
    }
}

struct PokemonDetail_Previews: PreviewProvider {
    static var previews: some View {
        PokemonDetail(
            types: ["Grass", "Water"],
            abilities: ["Overgrown" , "Chlorophyll"],
            moves: ["Razor wind", "Sword-Dance", "Cut", "Bind"],
            name: "Bulbasaur"
        )
    }
}

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

struct PokemonImage: View {
    var pokemonImage: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .frame(maxWidth: .infinity)
                .frame(height: 300)
                .foregroundColor(.white)
            Image(systemName: pokemonImage)
                .resizable()
                .frame(width: 100, height: 100)
                .foregroundColor(.pink)
        }
    }
}

struct PokemonTypeIconView: View {
    var icon: String
    
    var body: some View {
        ZStack {
            Circle()
                .frame(width: 30, height: 30)
                .foregroundColor(.white)
            Image(systemName: icon)
        }
    }
}

struct BadgeTypeView: View {
    var type: String
    var icon: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            RoundedRectangle(cornerRadius: 25)
                .foregroundColor(.gray)
            HStack {
                PokemonTypeIconView(icon: icon)
                    .padding(.vertical, 8)
                    .padding(.leading, 8)
                Text(type)
                    .font(.footnote)
                    .foregroundColor(.white)
                    .padding(.trailing, 10)
            }
        }
    }
}

struct PokeTypeView: View {
    var types: [String]
    var title: String
    
    var body: some View {
        ContainerInfoView(title: title) {
            HStack {
                ForEach(types, id: \.self) { type in
                    BadgeTypeView(type: type, icon: "leaf")
                }
            }
        }
    }
}

struct PokemonNameView: View {
    var name: String
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Name")
                .font(.callout)
                .foregroundColor(.white)
            Text(name)
                .font(.title)
                .foregroundColor(.white)
        }
    }
}

struct AbilitiesView: View {
    var abilities: [String]
    var title: String
    
    var body: some View {
        ContainerInfoView(title: title) {
            HStack {
                ForEach(abilities, id: \.self) { ability in
                    Text(ability)
                        .font(.title2)
                        .foregroundColor(.gray)
                        .padding(.trailing, 10)
                }
            }
        }
    }
}

struct MovesView: View {
    var moves: [String]
    var title: String
    var body: some View {
        ContainerInfoView(title: title) {
            ForEach(Array(moves.enumerated()), id: \.1) { (index, move) in
                if index < 9 {
                    VStack {
                        Text(move)
                            .font(.title2)
                            .foregroundColor(.gray)
                    }
                }
            }
        }
    }
}
