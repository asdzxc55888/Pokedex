//
//  PokedexCoordinator.swift
//  Pokedex
//
//  Created by 何韋辰 on 2024/9/13.
//

import UIKit

struct PokedexCoordinator: Coordinator {
    var navigationController: UINavigationController

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // TODO: show pokedex view
    func start() {
        let viewController = TestingViewController()
        viewController.pokedexCoordinator = self
        navigationController.pushViewController(viewController, animated: true)
        //let pokedexViewController = PokedexViewController()
        //pokedexViewController.pokedexCoordinator = self
        //navigationController.pushViewController(pokedexViewController, animated: true)
    }
    
    func navigateToPokedex() {
        let pokedexViewController = PokedexViewController()
        pokedexViewController.pokedexCoordinator = self
        navigationController.pushViewController(pokedexViewController, animated: true)
    }
    
    // TODO: navigate to pokedex number view
    func navigateToPokedexNumber() {
    }
    
    func goBack() {
        navigationController.popViewController(animated: true)
    }
}

