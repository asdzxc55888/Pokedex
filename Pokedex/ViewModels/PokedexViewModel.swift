//
//  PokedexViewModel.swift
//  Pokedex
//
//  Created by 何韋辰 on 2024/9/14.
//

import Foundation

final class PokedexViewModel {
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
    var loadingState: LoadingState = .idle
    var onPokemonListUpdate: ((_ updateCount: Int) -> Void)?
    
    //MARK: throttle prevent fetch too many times in a moment.
    private var throttleTimer: Timer?
    private var isThrottling = false
    
    func fetchPokemonList(limit: Int = 20) {
        guard !isThrottling else { return }
        
        isThrottling = true
        loadingState = .loading
        
        throttleTimer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { [weak self] _ in
            self?.isThrottling = false
        }
        
        pokemonAPI.fetchPokemonList(offset: self.currentPokemonListOffset, limit: limit) { [weak self] result in
            switch result {
            case .success(let pokemonList):
                self?.pokemonListResponse = pokemonList
            case .failure(let error):
                print("Failed to fetch Pokemon list: \(error)")
            }
            
            self?.loadingState = .idle
        }
        
        currentPokemonListOffset += limit
    }
}

extension PokedexViewModel {
    enum LoadingState {
        case loading
        case idle
    }
}
