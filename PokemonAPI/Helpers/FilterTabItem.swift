//
//  TabBarItem.swift
//  PokemonAPI
//
//  Created by Michael Conchado on 21/04/23.
//

import Foundation
import Combine

enum FilterTabItem: Hashable {
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
