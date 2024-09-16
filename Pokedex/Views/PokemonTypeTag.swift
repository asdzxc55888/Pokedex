//
//  PokemonTypeTag.swift
//  Pokedex
//
//  Created by 何韋辰 on 2024/9/16.
//

import UIKit

final class PokemonTypeTag: UIView {
    var type: PokemonType?
    private let label = UILabel()

    init() {
        super.init(frame: .zero)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let labelView: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // 設置 tag 的外觀
    private func setupTag() {
        backgroundColor = type?.color ?? .clear
        
        // 設置圓角
        layer.cornerRadius = 8
        layer.masksToBounds = true
        
        labelView.text = type?.rawValue.capitalized ?? "Error"
        
        addSubview(labelView)
        
        NSLayoutConstraint.activate([
            labelView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            labelView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),
            labelView.topAnchor.constraint(equalTo: topAnchor, constant: 4),
            labelView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4)
        ])
    }
    
    func configure(with type: PokemonType) {
        self.type = type
        setupTag()
    }
}

#Preview {
    let pokemonTypeTag = PokemonTypeTag()
    pokemonTypeTag.configure(with: .normal)
    return pokemonTypeTag
}
