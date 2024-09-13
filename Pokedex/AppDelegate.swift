//
//  AppDelegate.swift
//  Pokedex
//
//  Created by 何韋辰 on 2024/9/13.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var pokedexCoordinator: PokedexCoordinator?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let navigationController = UINavigationController()
        pokedexCoordinator = PokedexCoordinator(navigationController: navigationController)
        pokedexCoordinator?.start()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }

}

