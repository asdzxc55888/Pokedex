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
    
    private let stackView = UIStackView()
    private let tableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupStackView()
        setupTableView()
        
        viewModel.fetchPokemonList()
        
        viewModel.onPokemonListUpdate = self.onPokemonListUpdate
    }
    
    private func setupStackView() {
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView.topAnchor.constraint(equalTo: view.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupTableView() {
        tableView.frame = view.bounds
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(PokemonTableViewCell.self, forCellReuseIdentifier: "PokemonCell")
        tableView.register(LoadingMoreTableViewCell.self, forCellReuseIdentifier: "LoadingMoreCell")
        tableView.separatorStyle = .none
        tableView.rowHeight = 100
        stackView.addArrangedSubview(tableView)
    }
    
    private func onPokemonListUpdate(updatedCount: Int) {
        self.tableView.performBatchUpdates({
            let startIndex = self.viewModel.pokemonList.count - updatedCount
            let endIndex = self.viewModel.pokemonList.count - 1
            let indexPaths = (startIndex...endIndex).map { IndexPath(row: $0, section: 0) }
            self.tableView.insertRows(at: indexPaths, with: .automatic)
        }, completion: nil)
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
        
        if position > contentHeight - scrollViewHeight - 50 {
            viewModel.fetchPokemonList()
        }
    }
}

extension PokedexViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var row = viewModel.pokemonList.count
        
        if viewModel.loadingState == .loading {
            row += 1
        }
        
        return row
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == self.viewModel.pokemonList.count {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "LoadingMoreCell") as? LoadingMoreTableViewCell else {
                return UITableViewCell()
            }
            cell.startLoading()
            return cell
        } else {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath) as? PokemonTableViewCell else {
                return UITableViewCell()
            }
            let pokemon = viewModel.pokemonList[indexPath.row]
            cell.configure(with: pokemon.name, index: indexPath.row)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard indexPath.row < viewModel.pokemonList.count else { return }
        
        if let imageUrl = PokemonAPI.getPokemonImageUrl(pokemonIndex: indexPath.row + 1) {
            ImageCache.default.removeImage(forKey: imageUrl.absoluteString)
        }
    }
}

#Preview {
    PokedexViewController()
}
