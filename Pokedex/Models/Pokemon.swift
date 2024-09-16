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
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            let typeContainer = try container.nestedContainer(keyedBy: TypeKeys.self, forKey: .type)
            let typeName = try typeContainer.decode(String.self, forKey: .name)
            
            self.type = PokemonType(rawValue: typeName) ?? .unknown
        }
        
        private enum CodingKeys: String, CodingKey {
            case type
        }
        
        private enum TypeKeys: String, CodingKey {
            case name
        }
        
    }
}
