//
//  TabBarItem.swift
//  PokemonAPI
//
//  Created by Michael Conchado on 21/04/23.
//

import Foundation
import Combine

enum TabBarItem: Hashable {
    case name, ability
    
    var title : String {
        switch self {
        case .name:
            return "name"
        case .ability:
            return "ability"
        }
    }
}
