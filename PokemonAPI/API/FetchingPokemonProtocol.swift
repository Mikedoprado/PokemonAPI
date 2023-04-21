//
//  FetchingPokemonProtocol.swift
//  PokemonAPI
//
//  Created by Michael Conchado on 20/04/23.
//

import Foundation

protocol FetchingPokemonProtocol {
    func getPokeItemList(url: URL, completion: @escaping (Result<[Pokemon], Error>) -> Void)
    func getPokemonList(pokemonURLs: [String], completion: @escaping (Result<[Pokemon], Error>) -> Void)
}
