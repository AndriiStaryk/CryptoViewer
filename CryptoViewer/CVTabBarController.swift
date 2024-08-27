//
//  CVTabBarController.swift
//  CryptoViewer
//
//  Created by Andrii Staryk on 27.08.2024.
//

import UIKit

class CVTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }
    
    private func configure() {
        let selectedColor = UIColor.systemPurple
        let normalColor = UIColor.systemGray
        
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor.systemBackground
        appearance.stackedLayoutAppearance.selected.iconColor = selectedColor
        appearance.stackedLayoutAppearance.normal.iconColor = normalColor
        appearance.stackedLayoutAppearance.selected.titleTextAttributes = [.foregroundColor: selectedColor]
        appearance.stackedLayoutAppearance.normal.titleTextAttributes = [.foregroundColor: normalColor]

        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
        
        viewControllers = [createTrendingCryptosVC(), createFavoriteCryptosVC()]
        //view.backgroundColor = .systemBackground
    }
    
    private func createTrendingCryptosVC() -> UINavigationController {
        let trendingCryptosVC = CVTrendingCryptosViewController()
        trendingCryptosVC.title = "Trending"
        trendingCryptosVC.tabBarItem = UITabBarItem.init(tabBarSystemItem: .mostViewed, tag: 0)
        
        return UINavigationController(rootViewController: trendingCryptosVC)
    }
    
    
    private func createFavoriteCryptosVC() -> UINavigationController {
        let favoriteCryptosVC = CVFavoriteCryptosViewController()
        favoriteCryptosVC.title = "Favorites"
        favoriteCryptosVC.tabBarItem = UITabBarItem.init(tabBarSystemItem: .favorites, tag: 1)
        
        return UINavigationController(rootViewController: favoriteCryptosVC)
    }
}


    #Preview {
        CVTabBarController()
    }

