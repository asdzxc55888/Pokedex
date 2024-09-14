//
//  PokedexViewModel.swift
//  Pokedex
//
//  Created by 何韋辰 on 2024/9/14.
//

import Foundation

class PokedexViewModel {
    private let pokemonAPI = PokemonAPI(networkService: NetworkService())
    private var currentPokemonListOffset = 0
    var pokemonListResponse: PokemonListResponse? {
        didSet {
            let newList =  pokemonListResponse?.results ?? []
            self.pokemonList += newList
            onPokemonListUpdate?(newList.count)
        }
    }
    var pokemonList: [PokemonListResponse.PokemonResult] = []
    var onPokemonListUpdate: ((_ updateCount: Int) -> Void)?
    
    private var debounceTimer: Timer?
    
    func fetchPokemonList(limit: Int = 20) {
        debounceTimer?.invalidate()
        
        debounceTimer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { [weak self] _ in
            guard let self = self else { return }
            
            pokemonAPI.fetchPokemonList(offset: self.currentPokemonListOffset, limit: limit) { [weak self] result in
                switch result {
                case .success(let pokemonList):
                    self?.pokemonListResponse = pokemonList
                case .failure(let error):
                    print("Failed to fetch Pokemon list: \(error)")
                }
            }
            
            currentPokemonListOffset += limit
        }
    }
}
