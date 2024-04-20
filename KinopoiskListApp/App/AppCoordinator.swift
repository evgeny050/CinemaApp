//
//  AppCoordinator.swift
//  KinopoiskListApp
//
//  Created by Флоранс on 20.04.2024.
//

import UIKit

class AppCoordinator {
    static func createTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        let homeVC = HomeInfoViewController()
        HomeInfoConfigurator.configure(withView: homeVC)
        let homeNavVC = UINavigationController(rootViewController: homeVC)
        let profileVC = ProfileViewController()
        
        tabBarController.setViewControllers([homeNavVC, profileVC], animated: false)
        
        let tabBarAppearance = UITabBarAppearance()
        
        tabBarAppearance.configureWithOpaqueBackground()
        
        tabBarController.tabBar.standardAppearance = tabBarAppearance
        tabBarController.tabBar.scrollEdgeAppearance = tabBarAppearance
        
        homeNavVC.tabBarItem = UITabBarItem(title: "Поиск", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 1)
        
        return tabBarController
    }
}
