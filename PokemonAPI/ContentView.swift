//
//  ContentView.swift
//  PokemonAPI
//
//  Created by Michael Conchado on 15/04/23.
//

import SwiftUI

var list = [
    Pokemon(id: 1, name: "Bulbasaur", types: ["Grass"], abilities: ["Cutting Leaf"], sprites: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/1.png", moves: [""]),
    Pokemon(id: 2, name: "Ivysaur", types: ["Grass", "Fairy"], abilities: ["Cutting Leaf"], sprites: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/2.png", moves: [""]),
    Pokemon(id: 3, name: "Venusaur", types: ["Grass"], abilities: ["Cutting Leaf"], sprites: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/3.png", moves: [""]),
    Pokemon(id: 4, name: "Charmander", types: ["Fire"], abilities: ["Fire ball"], sprites: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/4.png", moves: [""]),
    Pokemon(id: 5, name: "Charmeleon", types: ["Fire"], abilities: ["Fire ball"], sprites: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/5.png", moves: [""]),
]

struct ContentView: View {
    var body: some View {
        NavigationPokeList(list: list)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


