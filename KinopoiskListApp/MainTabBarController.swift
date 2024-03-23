//
//  MainTabBarController.swift
//  KinopoiskListApp
//
//  Created by Флоранс on 15.03.2024.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    private lazy var homeVC = HomeViewController()
    private lazy var profileVC = ProfileViewController()

    
    override func viewDidLoad() {
        viewControllers = [
            homeVC,
            profileVC
        ]
        
        setupTabBar()
    }
    
    private func setupTabBar() {
        let tabBarAppearance = UITabBarAppearance()
        
        tabBarAppearance.configureWithOpaqueBackground()
        
        tabBar.standardAppearance = tabBarAppearance
        tabBar.scrollEdgeAppearance = tabBarAppearance
        
        homeVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house"), tag: 1)
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), tag: 1)
    }
    
}
