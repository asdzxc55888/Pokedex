//
//  Pokemon.swift
//  Pokedex
//
//  Created by 何韋辰 on 2024/9/14.
//

import Foundation

struct Pokemon: Decodable {
    let id: Int
    let name: String
    let sprites: Sprite
    let types: [TypeEntry]
    
    var imageUrl: URL? {
        PokemonAPI.getPokemonImageUrl(pokemonIndex: id)
    }
    
    struct Sprite: Decodable {
        let front_default: String
    }

    struct TypeEntry: Decodable {
        let type: PokemonType
        struct PokemonType: Decodable {
            let name: String
        }
    }
}
