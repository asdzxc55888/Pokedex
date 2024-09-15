//
//  PokemonTableViewCell.swift
//  Pokedex
//
//  Created by 何韋辰 on 2024/9/14.
//

import UIKit
import Kingfisher

final class PokemonTableViewCell: UITableViewCell {
    
    private let pokemonImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(pokemonImageView)
        contentView.addSubview(nameLabel)
        
        // 設置 ImageView 和 Label 的約束條件
        NSLayoutConstraint.activate([
            pokemonImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            pokemonImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            pokemonImageView.widthAnchor.constraint(equalToConstant: 80),
            pokemonImageView.heightAnchor.constraint(equalToConstant: 80),
            
            nameLabel.leadingAnchor.constraint(equalTo: pokemonImageView.trailingAnchor, constant: 10),
            nameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with pokemonName: String, index: Int) {
        nameLabel.text = "NO.\(String(index + 1)) \(pokemonName.capitalized)"
        
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
        // pokemonAPI.fetchPokemonDetails(pokemonName: pokemonName) { [weak self] result in
        //     switch result {
        //     case .success(let pokemon):
        //         if let imageUrl = pokemon.imageUrl {
        //             self?.pokemonImageView.kf.setImage(with: imageUrl)
        //         }
        //     case .failure(let error):
        //         print("Failed to get pokemon detail data! \(error)")
        //     }
        // }
    }
}


