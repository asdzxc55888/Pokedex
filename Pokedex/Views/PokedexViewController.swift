//
//  PokedexViewController.swift
//  Pokedex
//
//  Created by 何韋辰 on 2024/9/13.
//

import UIKit
import Kingfisher

final class PokedexViewController: UIViewController {
    var pokedexCoordinator: PokedexCoordinator?
    var viewModel: PokedexViewModel = .init()
    
    private let tableView = UITableView()
    private let activityIndicator = UIActivityIndicatorView(style: .medium)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .purple
        
        setupTableView()
        
        viewModel.fetchPokemonList()
        activityIndicator.startAnimating()
        
        viewModel.onPokemonListUpdate = { [weak self] updatedCount in
            guard let self else { return }
            
            self.tableView.performBatchUpdates({
                let startIndex = self.viewModel.pokemonList.count - updatedCount
                let endIndex = self.viewModel.pokemonList.count - 1
                let indexPaths = (startIndex...endIndex).map { IndexPath(row: $0, section: 0) }
                self.tableView.insertRows(at: indexPaths, with: .automatic)
            }, completion: nil)
            
            self.activityIndicator.stopAnimating()
            //self?.tableView.reloadData()
        }
    }
    
    private func setupTableView() {
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PokemonTableViewCell.self, forCellReuseIdentifier: "PokemonCell")
        tableView.separatorStyle = .singleLine
        tableView.rowHeight = 100
        view.addSubview(tableView)
    }
    
    private func setupActivityIndicator() {
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
    }
}

extension PokedexViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pokemon = viewModel.pokemonList[indexPath.row]
        print("Selected Pokemon: \(pokemon.name)")
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let scrollViewHeight = scrollView.frame.size.height
        
        if position > contentHeight - scrollViewHeight - 100 {
            viewModel.fetchPokemonList()
        }
    }
}

extension PokedexViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.pokemonList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath) as? PokemonTableViewCell else {
            return UITableViewCell()
        }
        
        let pokemon = viewModel.pokemonList[indexPath.row]
        cell.configure(with: pokemon.name, index: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let pokemon = viewModel.pokemonList[indexPath.row]
        
        if let imageUrl = PokemonAPI.getPokemonImageUrl(pokemonIndex: indexPath.row + 1) {
            ImageCache.default.removeImage(forKey: imageUrl.absoluteString)
        }
    }
}
