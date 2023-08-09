//
//  TabBarViewController.swift
//  MovieApp
//
//  Created by Tejada Ortigosa Miguel Angel on 8/8/23.
//

import Foundation

import UIKit

final class TabBarViewController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // HomeView
        let homeViewController = HomeViewController()
        homeViewController.tabBarItem = UITabBarItem(title: "Movies", image: UIImage(systemName: "house"), tag: 0)
        // searchView
        let searchViewController = SearchViewController(nibName: "SearchViewController", bundle: nil)
        searchViewController.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 1)
        
        self.tabBar.barTintColor = .black
        self.tabBar.unselectedItemTintColor = UIColor.white.withAlphaComponent(0.8)
        self.tabBar.selectedImageTintColor = .red
        self.tabBar.backgroundColor = UIColor(red: 44/255.0, green: 44/255.0, blue: 46/255.0, alpha: 0.9)
        
        self.tabBar.isTranslucent = true
        
        // Asignar los viewcontrollers al tab bar. El orden de los view controllers lo marca el orden del array de view controllers
        self.viewControllers = [homeViewController, searchViewController]
        navigationItem.hidesBackButton = true
    }
    
}
