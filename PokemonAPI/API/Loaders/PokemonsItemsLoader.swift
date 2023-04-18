//
//  PokemonsItemsLoader.swift
//  PokemonAPI
//
//  Created by Michael Conchado on 18/04/23.
//

import Foundation

typealias PokemonsItemsLoader = Loader<[PokeItem]>

extension PokemonsItemsLoader {
    convenience init(url: URL, client: HTTPClient) {
        self.init(url: url, client: client, mapper: PokeItemMapper.map)
    }
}
