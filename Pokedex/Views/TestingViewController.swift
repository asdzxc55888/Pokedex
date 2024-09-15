//
//  TestingViewController.swift
//  Pokedex
//
//  Created by 何韋辰 on 2024/9/15.
//

import UIKit

class TestingViewController: UIViewController {
    var pokedexCoordinator: PokedexCoordinator?

    // 建立一個按鈕
    let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Pokedex", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 設置背景顏色
        view.backgroundColor = .white

        // 將按鈕添加到視圖中
        view.addSubview(actionButton)

        // 設置按鈕的位置和大小（使用 Auto Layout）
        setupButtonConstraints()

        // 添加按鈕的點擊事件
        actionButton.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    // 設置按鈕的 Auto Layout 約束
    func setupButtonConstraints() {
        // 讓按鈕位於螢幕的中央
        NSLayoutConstraint.activate([
            actionButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            actionButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            actionButton.widthAnchor.constraint(equalToConstant: 200),
            actionButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    // 按鈕點擊時調用的方法
    @objc func buttonTapped() {
        pokedexCoordinator?.navigateToPokedex()
        print("Button was tapped!")
    }
}
