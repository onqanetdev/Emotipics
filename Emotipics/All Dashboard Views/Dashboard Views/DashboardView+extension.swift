////
////  DashboardView+extension.swift
////  Emotipics
////
////  Created by Onqanet on 05/03/25.
////
//
//import Foundation
//import UIKit
//
//
//extension DashboardViewController: UITabBarControllerDelegate {
//    
//    
//    
//    
//    
//    func setUpPlusView(){
//        view.addSubview(plusView)
//        
//        
//        NSLayoutConstraint.activate([
//            plusView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 100),
//            plusView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
//            plusView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 10),
//            plusView.heightAnchor.constraint(equalToConstant: 300)
//        ])
//        
//    }
//    
//    
//    
//    func setupTabBarController() {
//        // Create Tab Bar Controller
//        let tabBarController = UITabBarController()
//        tabBarController.delegate = self
//        tabBarController.tabBar.isTranslucent = false
//        tabBarController.tabBar.backgroundColor = .clear  // Set clear background to ensure visibility
//        
//        // Add custom background image
//        if let tabBarImage = UIImage(named: "TabbarBackGround") {
//            let imageView = UIImageView(image: tabBarImage)
//            imageView.contentMode = .scaleAspectFill
//            
//            // Adjust the position of the image upwards
//            let tabBarFrame = tabBarController.tabBar.bounds
//            imageView.frame = CGRect(
//                x: 0,
//                y: -35,  // Move it up by 10 points inside the tab bar
//                width: tabBarFrame.width,
//                height: tabBarFrame.height + 10 // Extend the height slightly
//            )
//            
//            tabBarController.tabBar.insertSubview(imageView, at: 0) // Add inside tab bar to prevent blocking
//        }
//        
//      
//        let firstViewController = EntryViewController()
//        firstViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "HomeDash"), tag: 0)
//        
//       
//        let secondViewController = CatalogueViewController()
//        secondViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "folder"), tag: 1)
//        
//       
//        
//        let thirdViewController = UIViewController()
//        thirdViewController.tabBarItem = UITabBarItem(title: nil, image: nil, tag: 2)
//        thirdViewController.view.backgroundColor = .systemBlue
//        
//        let floatingButton = UIButton(type: .custom)
//       
//        floatingButton.setBackgroundImage(UIImage(named: "PlusIcon"), for: .normal)
//        
//        floatingButton.layer.cornerRadius = 30  // Make it circular
//        
//        
//        floatingButton.translatesAutoresizingMaskIntoConstraints = false
//        
//        tabBarController.view.addSubview(floatingButton)
//        
//        NSLayoutConstraint.activate([
//            floatingButton.centerXAnchor.constraint(equalTo: tabBarController.tabBar.centerXAnchor),
//            floatingButton.bottomAnchor.constraint(equalTo: tabBarController.tabBar.topAnchor, constant: 20), // Move upwards
//            floatingButton.widthAnchor.constraint(equalToConstant: 60),
//            floatingButton.heightAnchor.constraint(equalToConstant: 60)
//        ])
//        
//        
//        
//        
//        
//        let spacer = UIViewController()
//        spacer.tabBarItem = UITabBarItem(title: "", image: nil, tag: -1)
//        
//        let fourthViewController = ContactsViewController()
//        fourthViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "person"), tag: 3)
//        fourthViewController.view.backgroundColor = .systemOrange
//        
//
//        let fifthViewController = GroupListViewController()
//        fifthViewController.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "person.3"), tag: 4)
//
//        fifthViewController.view.backgroundColor = .systemPurple
//        
//       
//        tabBarController.viewControllers = [
//            firstViewController,
//            secondViewController,
//            //spacer,
//            thirdViewController,
//            fourthViewController,
//            fifthViewController
//        ]
//        
//        tabBarController.selectedIndex = 0
//        
//        addChild(tabBarController)
//        view.addSubview(tabBarController.view)
//        tabBarController.view.frame = view.bounds
//        tabBarController.didMove(toParent: self)
//    }
//    
//    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
//            print("tab pressed")
//        
//        
//        if let tag = viewController.tabBarItem.tag as Int? {
//                    print("Tab pressed Tag: \(tag)")
//            
//            if tag == 1 {
//                self.navigationController?.pushViewController(CatalogueViewController(), animated: true)
//                }
//            else if tag == 3 {
//                self.navigationController?.pushViewController(ContactsViewController(), animated: true)
//            }
//            else if tag == 4 {
//                self.navigationController?.pushViewController(GroupListViewController(), animated: true)
//            }
//            
//        }
//        
//        }
//}



import UIKit
import Foundation


extension DashboardViewController: UITabBarControllerDelegate {
    
    func setupTabBarController() {
        // Create Tab Bar Controller
        let tabBarController = UITabBarController()
        tabBarController.delegate = self
        tabBarController.tabBar.isTranslucent = false
        tabBarController.tabBar.backgroundColor = .clear
        
        
        
       
            tabBarController.tabBar.tintColor = .gray
        
        // Add custom background image
        if let tabBarImage = UIImage(named: "TabbarBackGround") {
            let imageView = UIImageView(image: tabBarImage)
            imageView.contentMode = .scaleAspectFill
            imageView.frame = CGRect(
                x: 0,
                y: -35,
                width: tabBarController.tabBar.bounds.width,
                height: tabBarController.tabBar.bounds.height + 10
            )
            imageView.tintColor = .brown
            tabBarController.tabBar.insertSubview(imageView, at: 0)
        }
        
        // Create empty view controllers for the tab bar items
        let homeTab = EntryViewController()
       // self.navigationController?.pushViewController(homeTab, animated: true)
        homeTab.userName = name
        homeTab.tabBarItem = UITabBarItem(title: nil, image: UIImage(named: "HomeDash"), tag: 0)
        homeTab.tabBarItem = UITabBarItem(
            title: nil,
            image: UIImage(named: "HomeDash")?.withRenderingMode(.alwaysOriginal), // Preserve original image color
            selectedImage: UIImage(named: "HomeDash")?.withTintColor(.systemBlue, renderingMode: .alwaysOriginal) // Set brown color
        )
        
        
       // let catalogueTab = UIViewController()
        let catalogueTab = EntryViewController()
        catalogueTab.userName = name
        catalogueTab.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "folder"), tag: 1)
        
        let plusTab = UIViewController()
        plusTab.tabBarItem = UITabBarItem(title: nil, image: nil, tag: 2)
        
        let contactsTab = EntryViewController()
        contactsTab.userName = name
        contactsTab.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "person"), tag: 3)
        
        let groupsTab = EntryViewController()
        groupsTab.userName = name
        groupsTab.tabBarItem = UITabBarItem(title: nil, image: UIImage(systemName: "person.3"), tag: 4)
        
        // Set up the floating plus button
        let floatingButton = UIButton(type: .custom)
        floatingButton.setBackgroundImage(UIImage(named: "PlusIcon"), for: .normal)
        floatingButton.layer.cornerRadius = 30
        floatingButton.translatesAutoresizingMaskIntoConstraints = false
        floatingButton.addTarget(self, action: #selector(plusButtonTapped), for: .touchUpInside)
        
        tabBarController.view.addSubview(floatingButton)
        
        NSLayoutConstraint.activate([
            floatingButton.centerXAnchor.constraint(equalTo: tabBarController.tabBar.centerXAnchor),
            floatingButton.bottomAnchor.constraint(equalTo: tabBarController.tabBar.topAnchor, constant: 20),
            floatingButton.widthAnchor.constraint(equalToConstant: 60),
            floatingButton.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        // Set the view controllers
        tabBarController.viewControllers = [homeTab, catalogueTab, plusTab, contactsTab, groupsTab]
        tabBarController.selectedIndex = 0
        
        // Add to parent view
        addChild(tabBarController)
        view.addSubview(tabBarController.view)
        tabBarController.view.frame = view.bounds
        tabBarController.didMove(toParent: self)
    }
    
    @objc func plusButtonTapped() {
        // Handle plus button action
        print("Plus button tapped")
        // Add your plus button logic here
    }
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if let tag = viewController.tabBarItem.tag as Int? {
            print("Tab pressed Tag: \(tag)")
            
            switch tag {
            case 0:
                
                
//                self.navigationController?.pushViewController(EntryViewController(), animated: true)
                print("Nothing From Here")
                
            case 1:
                // Catalogue tab
                
//                self.navigationController?.pushViewController(CatalogueViewController(), animated: true)
                
                self.navigationController?.pushViewController(NewCatalogueVC(), animated: true)
                
            case 2:
                // Plus tab - handled by button, reset selection
                plusButtonTapped()
                tabBarController.selectedIndex = 0
                
            case 3:
                // Contacts tab
                self.navigationController?.pushViewController(ContactsViewController(), animated: true)
                
            case 4:
                // Groups tab
                self.navigationController?.pushViewController(GroupListViewController(), animated: true)
            default:
                break
            }
        }
    }
}
