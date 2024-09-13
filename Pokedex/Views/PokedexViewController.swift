//
//  PokedexViewController.swift
//  Pokedex
//
//  Created by 何韋辰 on 2024/9/13.
//

import UIKit

class PokedexViewController: UIViewController {
    let pokemonAPI = PokemonAPI(networkService: NetworkService())
    var pokedexCoordinator: PokedexCoordinator?
    var pokemonList: PokemonListResponse?
    var currentPokemonListOffset = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .purple
        
        fetchPokemonList(offset: 0)
    }
    
    private func fetchPokemonList(offset: Int) {
        pokemonAPI.fetchPokemonList { [weak self] result in
            switch result {
            case .success(let pokemonList):
                self?.pokemonList = pokemonList
                self?.currentPokemonListOffset += pokemonList.results.count
            case .failure(let error):
                print("Failed to fetch Pokemon list: \(error)")
            }
        }
    }


}
