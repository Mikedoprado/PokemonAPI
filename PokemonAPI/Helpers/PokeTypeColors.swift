//
//  PokeTypeColors.swift
//  PokemonAPI
//
//  Created by Michael Conchado on 17/04/23.
//

import SwiftUI

enum PokeColor: String {
    case bug
    case dark
    case dragon
    case electric
    case fairy
    case fighting
    case fire
    case flying
    case ghost
    case grass
    case ground
    case ice
    case normal
    case poison
    case psychic
    case rock
    case steel
    case water
    case white
    
    var color: Color {
        switch self {
        case .bug:
            return PokeColor.colorLiteral(color: #colorLiteral(red: 0.4156862745, green: 0.8039215686, blue: 0.2352941176, alpha: 1))
        case .dark:
            return PokeColor.colorLiteral(color:  #colorLiteral(red: 0.146630764, green: 0.1301804483, blue: 0.129812032, alpha: 1))
        case .dragon:
            return PokeColor.colorLiteral(color:  #colorLiteral(red: 0.3725490196, green: 0.337254902, blue: 0.3294117647, alpha: 1))
        case .electric:
            return PokeColor.colorLiteral(color: #colorLiteral(red: 0.8509803922, green: 0.7019607843, blue: 0.1843137255, alpha: 1))
        case .fairy:
            return PokeColor.colorLiteral(color: #colorLiteral(red: 0.8941176471, green: 0.6666666667, blue: 0.9333333333, alpha: 1))
        case .fighting:
            return PokeColor.colorLiteral(color: #colorLiteral(red: 0.5803921569, green: 0.2274509804, blue: 0.2274509804, alpha: 1))
        case .fire:
            return PokeColor.colorLiteral(color: #colorLiteral(red: 0.9607843137, green: 0.2078431373, blue: 0.1058823529, alpha: 1))
        case .flying:
            return PokeColor.colorLiteral(color: #colorLiteral(red: 0.6431372549, green: 0.8274509804, blue: 1, alpha: 1))
        case .ghost:
            return PokeColor.colorLiteral(color: #colorLiteral(red: 0.5176470588, green: 0.03921568627, blue: 1, alpha: 1))
        case .grass:
            return PokeColor.colorLiteral(color: #colorLiteral(red: 0.2078431373, green: 0.5921568627, blue: 0.2, alpha: 1))
        case .ground:
            return PokeColor.colorLiteral(color: #colorLiteral(red: 0.3490196078, green: 0.2274509804, blue: 0.03921568627, alpha: 1))
        case .ice:
            return PokeColor.colorLiteral(color: #colorLiteral(red: 0.1607843137, green: 0.8745098039, blue: 0.8745098039, alpha: 1))
        case .normal:
            return PokeColor.colorLiteral(color: #colorLiteral(red: 0.5882352941, green: 0.5607843137, blue: 0.5607843137, alpha: 1))
        case .poison:
            return PokeColor.colorLiteral(color: #colorLiteral(red: 0.3882352941, green: 0.262745098, blue: 0.5450980392, alpha: 1))
        case .psychic:
            return PokeColor.colorLiteral(color: #colorLiteral(red: 0.8078431373, green: 0.137254902, blue: 0.9176470588, alpha: 1))
        case .rock:
            return PokeColor.colorLiteral(color: #colorLiteral(red: 0.5803921569, green: 0.4352941176, blue: 0.3333333333, alpha: 1))
        case .steel:
            return PokeColor.colorLiteral(color: #colorLiteral(red: 0.5176470588, green: 0.6549019608, blue: 0.662745098, alpha: 1))
        case .water:
            return PokeColor.colorLiteral(color: #colorLiteral(red: 0.2, green: 0.4588235294, blue: 0.6039215686, alpha: 1))
        case .white:
            return PokeColor.colorLiteral(color: #colorLiteral(red: 0.9719485641, green: 0.9719484448, blue: 0.9719485641, alpha: 1))
        }
    }
    
    static func colorLiteral(color: UIColor) -> Color {
        return Color(uiColor: color)
    }
}
