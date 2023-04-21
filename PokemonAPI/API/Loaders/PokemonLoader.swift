//
//  PokemonsLoader.swift
//  PokemonAPI
//
//  Created by Michael Conchado on 15/04/23.
//

import Foundation

typealias PokemonLoader = Loader<Pokemon>

extension PokemonLoader {
    convenience init(client: HTTPClient) {
        self.init(client: client, mapper: PokemonMapper.map)
    }
}
