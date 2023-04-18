//
//  EndPoint.swift
//  PokemonAPI
//
//  Created by Michael Conchado on 18/04/23.
//

import Foundation

enum Endpoint {
    case getPokeList
    case getPokemonByName(String)
    case getPokemonByType(String)

    public func url(baseURL: URL) -> URL {
        switch self {
        case .getPokeList:
            return baseURL.appendingPathComponent("/v2/pokemon")
        case let .getPokemonByName(name):
            return baseURL.appendingPathComponent("/v2/pokemon/\(name)")
        case let .getPokemonByType(type):
            return baseURL.appendingPathComponent("/v2/type/\(type)")
        }
    }
}
