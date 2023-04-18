//
//  PokemonsLoader.swift
//  PokemonAPI
//
//  Created by Michael Conchado on 15/04/23.
//

import Foundation

typealias PokemonsLoader = Loader<[Pokemon]>

extension PokemonsLoader {
    convenience init(url: URL, client: HTTPClient) {
        self.init(url: url, client: client, mapper: PokemonsMapper.map)
    }
}
