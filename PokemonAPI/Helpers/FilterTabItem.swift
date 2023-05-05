//
//  TabBarItem.swift
//  PokemonAPI
//
//  Created by Michael Conchado on 21/04/23.
//

import Foundation
import Combine

enum FilterTabItem: Hashable, Equatable {
    case name, type, ability
    
    var title : String {
        switch self {
        case .name:
            return "name"
        case .type:
            return "type"
        case .ability:
            return "ability"
        }
    }
}

extension FilterTabItem {
    
    func getURLByFilter(searchText: String) -> URL {
        switch self {
        case .name:
            return Endpoint.getPokemonByName(searchText.lowercased()).url(baseURL: baseURL)
        case .type:
            return Endpoint.getPokemonByType(searchText.lowercased()).url(baseURL: baseURL)
        case .ability:
            return Endpoint.getPokemonByAbility(searchText.lowercased()).url(baseURL: baseURL)
        }
    }
}
