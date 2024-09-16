//
//  PokemonType.swift
//  Pokedex
//
//  Created by 何韋辰 on 2024/9/16.
//

import UIKit

enum PokemonType: String, Decodable {
    case normal
    case fighting
    case flying
    case poison
    case ground
    case rock
    case bug
    case ghost
    case steel
    case fire
    case water
    case grass
    case electric
    case psychic
    case ice
    case dragon
    case dark
    case fairy
    case stellar
    case unknown
}

extension PokemonType {
    var color: UIColor {
        switch self {
        case .normal:
            return UIColor(hex: "#A8A77A")
        case .fighting:
            return UIColor(hex: "#C22E28")
        case .flying:
            return UIColor(hex: "#A98FF3")
        case .poison:
            return UIColor(hex: "#A33EA1")
        case .ground:
            return UIColor(hex: "#E2BF65")
        case .rock:
            return UIColor(hex: "#B6A136")
        case .bug:
            return UIColor(hex: "#A6B91A")
        case .ghost:
            return UIColor(hex: "#735797")
        case .steel:
            return UIColor(hex: "#B7B7CE")
        case .fire:
            return UIColor(hex: "#EE8130")
        case .water:
            return UIColor(hex: "#6390F0")
        case .grass:
            return UIColor(hex: "#7AC74C")
        case .electric:
            return UIColor(hex: "#F7D02C")
        case .psychic:
            return UIColor(hex: "#F95587")
        case .ice:
            return UIColor(hex: "#96D9D6")
        case .dragon:
            return UIColor(hex: "#6F35FC")
        case .dark:
            return UIColor(hex: "#705746")
        case .fairy:
            return UIColor(hex: "#D685AD")
        case .stellar:
            return UIColor(hex: "#9B59B6")
        case .unknown:
            return UIColor(hex: "#A8A77A")
        }
    }
}
