//
//  PokemonTableViewCell.swift
//  Pokedex
//
//  Created by 何韋辰 on 2024/9/14.
//

import UIKit
import Kingfisher

final class PokemonTableViewCell: UITableViewCell {
    var pokemon: Pokemon?
    
    private let pokemonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private lazy var pokemonTypeTagsView: UIStackView = {
        guard let pokemon else { return UIStackView() }
        
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        for type in pokemon.types {
            let pokemonTypeTag = PokemonTypeTag()
            pokemonTypeTag.configure(with: type.type)
            stackView.addArrangedSubview(pokemonTypeTag)
        }
        
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        stackView.addArrangedSubview(nameLabel)
        
        contentView.backgroundColor = CustomColor.skyblue
        contentView.addSubview(pokemonImageView)
        contentView.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            pokemonImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            pokemonImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            pokemonImageView.widthAnchor.constraint(equalToConstant: 80),
            pokemonImageView.heightAnchor.constraint(equalToConstant: 80),
            
            stackView.leadingAnchor.constraint(equalTo: pokemonImageView.trailingAnchor, constant: 8),
            stackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with pokemonName: String, index: Int) {
        nameLabel.text = "NO.\(String(index + 1)) \(pokemonName.capitalized)"
        
        let pokemonAPI = PokemonAPI(networkService: NetworkService())
        pokemonAPI.fetchPokemonDetails(pokemonName: pokemonName, completion: { [weak self] result in
            guard let self else { return }
            
            switch result {
            case .success(let pokemon):
                self.pokemon = pokemon
                self.stackView.addArrangedSubview(self.pokemonTypeTagsView)
            case .failure(let failure):
                print("Failed to get pokemon: \((failure))")
            }
        })
        
        if let imageUrl = PokemonAPI.getPokemonImageUrl(pokemonIndex: index + 1) {
            pokemonImageView.kf.setImage(
                with: imageUrl,
                options: [
                    .processor(DownsamplingImageProcessor(size: pokemonImageView.bounds.size)), // 適配圖片大小
                    .scaleFactor(UIScreen.main.scale),
                    .cacheOriginalImage
                ]
            )
        }
    }
}

#Preview {
    let pokemonTableViewCell = PokemonTableViewCell()
    pokemonTableViewCell.configure(with: "bulbasaur", index: 0)
    return pokemonTableViewCell
}

