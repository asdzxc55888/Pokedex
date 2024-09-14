//
//  PokemonAPI.swift
//  Pokedex
//
//  Created by 何韋辰 on 2024/9/13.
//

import Foundation

struct PokemonListResponse: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [PokemonResult]
    
    struct PokemonResult: Decodable {
        let name: String
        let url: String
    }
}

let POKEMON_MAX_INDEX = 1025

class PokemonAPI {
    let networkService: NetworkServiceProtocol
    
    init(networkService: NetworkServiceProtocol) {
        self.networkService = networkService
    }
    
    static func getPokemonImageUrl(pokemonIndex: Int) -> URL? {
        guard pokemonIndex > 0 && pokemonIndex <= POKEMON_MAX_INDEX else {
            return nil
        }
        
        if let url = URL(string: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/official-artwork/\(String(pokemonIndex)).png") {
            return url
        }
        return nil
    }
    
    // MARK: fetch pokemon list, offset: the pokemon index offset
    func fetchPokemonList(offset: Int = 0, limit: Int = 20, completion: @escaping (Result<PokemonListResponse, Error>) -> Void) {
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=\(String(limit))&offset=\(String(offset))") else {
            completion(.failure(NSError(domain: "PokemonAPIError", code: 1)))
            return
        }
        
        networkService.fetch(url: url) { (result: Result<PokemonListResponse, Error>) in
            completion(result)
        }
    }
    
    func fetchPokemonDetails(pokemonName: String, completion: @escaping (Result<Pokemon, Error>) -> Void) {
        fetchPokemonDetails(pokemonURL: "https://pokeapi.co/api/v2/pokemon/\(pokemonName)/", completion: completion)
    }
    
    func fetchPokemonDetails(pokemonURL: String, completion: @escaping (Result<Pokemon, Error>) -> Void) {
        guard let url = URL(string: pokemonURL) else {
            let error = NSError(domain: "PokemonServiceError", code: 2, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
            completion(.failure(error))
            return
        }
        
        networkService.fetch(url: url) { (result: Result<Pokemon, Error>) in
            switch result {
            case .success(let pokemon):
                completion(.success(pokemon))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
