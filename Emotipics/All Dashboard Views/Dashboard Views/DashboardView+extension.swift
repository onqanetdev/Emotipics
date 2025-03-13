//
//  DashboardView+extension.swift
//  Emotipics
//
//  Created by Onqanet on 05/03/25.
//

import Foundation
import UIKit


extension DashboardViewController {
    
    
    
    
    
    func setUpPlusView(){
        view.addSubview(plusView)
        
        
        NSLayoutConstraint.activate([
            plusView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 100),
            plusView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            plusView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 10),
            plusView.heightAnchor.constraint(equalToConstant: 300)
        ])
        
    }
    
    
    
    func setupTabBarController() {
        // Create Tab Bar Controller
        let tabBarController = UITabBarController()
        tabBarController.tabBar.isTranslucent = false
        tabBarController.tabBar.backgroundColor = .clear  // Set clear background to ensure visibility
        
        // Add custom background image
        if let tabBarImage = UIImage(named: "TabbarBackGround") {
            let imageView = UIImageView(image: tabBarImage)
            imageView.contentMode = .scaleAspectFill
            
            // Adjust the position of the image upwards
            let tabBarFrame = tabBarController.tabBar.bounds
            imageView.frame = CGRect(
                x: 0,
                y: -35,  // Move it up by 10 points inside the tab bar
                width: tabBarFrame.width,
                height: tabBarFrame.height + 10 // Extend the height slightly
            )
            
            tabBarController.tabBar.insertSubview(imageView, at: 0) // Add inside tab bar to prevent blocking
        }
        
        // Create View Controllers for each tab
        let firstViewController = EntryViewController()
        firstViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "HomeDash"), tag: 0)
        
        //        let secondViewController = UIViewController()
        let secondViewController = CatalogueViewController()
        secondViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "folder"), tag: 1)
        
        //secondViewController.view.backgroundColor = .systemGreen
        
        let thirdViewController = UIViewController()
        thirdViewController.tabBarItem = UITabBarItem(title: nil, image: nil, tag: 2)
        thirdViewController.view.backgroundColor = .systemBlue
        
        let floatingButton = UIButton(type: .custom)
        // floatingButton.setImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        floatingButton.setBackgroundImage(UIImage(named: "PlusIcon"), for: .normal)
        
        floatingButton.layer.cornerRadius = 30  // Make it circular
        
        
        floatingButton.translatesAutoresizingMaskIntoConstraints = false
        
        //floatingButton.isHidden = true
        
        tabBarController.view.addSubview(floatingButton)
        
        NSLayoutConstraint.activate([
            floatingButton.centerXAnchor.constraint(equalTo: tabBarController.tabBar.centerXAnchor),
            floatingButton.bottomAnchor.constraint(equalTo: tabBarController.tabBar.topAnchor, constant: 20), // Move upwards
            floatingButton.widthAnchor.constraint(equalToConstant: 60),
            floatingButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        
        
        
        
        let spacer = UIViewController()
        spacer.tabBarItem = UITabBarItem(title: "", image: nil, tag: -1)
        
        let fourthViewController = ContactsViewController()
        fourthViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "person"), tag: 3)
        fourthViewController.view.backgroundColor = .systemOrange
        
        let fifthViewController = UIViewController()
        fifthViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "person.3"), tag: 4)
        fifthViewController.view.backgroundColor = .systemPurple
        
        // Set view controllers for tab bar
        tabBarController.viewControllers = [
            firstViewController,
            secondViewController,
            //spacer,
            thirdViewController,
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
