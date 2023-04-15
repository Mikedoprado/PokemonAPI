//
//  PokemonsLoader.swift
//  PokemonAPI
//
//  Created by Michael Conchado on 15/04/23.
//

import Foundation

protocol PokemonsLoader {
    typealias LoadPokemonResult = Result<[Pokemon], Swift.Error>
    func load(completion: @escaping (LoadPokemonResult) -> Void)
}
