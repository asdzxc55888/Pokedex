//
//  CoordinatorPotocol.swift
//  Pokedex
//
//  Created by 何韋辰 on 2024/9/13.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    func start()
}
