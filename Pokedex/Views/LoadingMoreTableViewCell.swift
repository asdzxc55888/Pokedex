//
//  LoadingMoreTableViewCell.swift
//  Pokedex
//
//  Created by 何韋辰 on 2024/9/16.
//

import UIKit

class LoadingMoreTableViewCell: UITableViewCell {
    private let activityIndicator = UIActivityIndicatorView(style: .medium)
    private let loadingLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        loadingLabel.text = "Loading more..."
        loadingLabel.font = UIFont.systemFont(ofSize: 16)
        loadingLabel.textColor = .gray
        loadingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(activityIndicator)
        contentView.addSubview(loadingLabel)
        
        NSLayoutConstraint.activate([
            activityIndicator.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            activityIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            loadingLabel.leadingAnchor.constraint(equalTo: activityIndicator.trailingAnchor, constant: 10),
            loadingLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    func startLoading() {
        activityIndicator.startAnimating()
        loadingLabel.isHidden = false
    }
    
    func stopLoading() {
        activityIndicator.stopAnimating()
        loadingLabel.isHidden = true
    }
}
