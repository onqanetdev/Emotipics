//
//  DashboardView+extension.swift
//  Emotipics
//
//  Created by Onqanet on 05/03/25.
//

import Foundation
import UIKit


extension DashboardViewController {
     func setupTabBarController() {
        // Create Tab Bar Controller
        let tabBarController = UITabBarController()
        tabBarController.tabBar.backgroundColor = .white // Set a solid background color
        tabBarController.tabBar.isTranslucent = false
        // Create View Controllers for each tab
        let firstViewController = UIViewController()
        firstViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "HomeDash"), tag: 0)
        
        
        let secondViewController = UIViewController()
        secondViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "folder"), tag: 1)
        secondViewController.view.backgroundColor = .systemGreen
        
        let thirdViewController = UIViewController()
        thirdViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "plus.circle.fill"), tag: 2)
        thirdViewController.view.backgroundColor = .systemBlue
        
        let spacer = UIViewController()
        spacer.tabBarItem = UITabBarItem(title: "", image: nil, tag: -1)
        
        let fourthViewController = UIViewController()
        fourthViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "person"), tag: 3)
        fourthViewController.view.backgroundColor = .systemOrange
        
        let fifthViewController = UIViewController()
        fifthViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "person.3"), tag: 4)
        fifthViewController.view.backgroundColor = .systemPurple
        
        // Set view controllers for tab bar
        tabBarController.viewControllers = [
            firstViewController,
            secondViewController,
            // thirdViewController,
            spacer,
            fourthViewController,
            fifthViewController
        ]
        
        
        tabBarController.selectedIndex = 0
        
        
        addChild(tabBarController)
        view.addSubview(tabBarController.view)
        tabBarController.view.frame = view.bounds
        tabBarController.didMove(toParent: self)
    }
}
