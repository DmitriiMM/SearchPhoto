//
//  MainTabBar.swift
//  WhiteAndFluffyTest
//
//  Created by Дмитрий Мартынов on 29.01.2022.
//

import UIKit

class MainTabBar: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        tabBar.tintColor = .label
        setupVCs()
        
    }
    
    fileprivate func createNavController(for rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.prefersLargeTitles = true
        rootViewController.navigationItem.title = title
        return navController
    }
    
    func setupVCs() {
        let collectionNavVC = createNavController(for: CollectionViewController(),
                                                 title: NSLocalizedString("Search", comment: ""),
                                                 image: UIImage(systemName: "magnifyingglass")!)
        
        let tableNavVC =  createNavController(for: TableViewController(),
                                                title: NSLocalizedString("Favourite", comment: ""),
                                                image: UIImage(systemName: "star.fill")!)
        
        viewControllers = [
            collectionNavVC,
            tableNavVC,
        ]
    }
    
}
