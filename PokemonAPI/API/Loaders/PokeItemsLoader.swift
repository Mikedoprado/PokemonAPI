//
//  PokemonsItemsLoader.swift
//  PokemonAPI
//
//  Created by Michael Conchado on 18/04/23.
//

import Foundation

typealias PokeItemsLoader = Loader<[PokeItem]>

extension PokeItemsLoader {
    convenience init(client: HTTPClient) {
        self.init(client: client, mapper: PokeItemMapper.map)
    }
}
