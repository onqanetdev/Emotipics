//
//  DashboardViewController.swift
//  Emotipics
//
//  Created by Onqanet on 04/03/25.
//

import UIKit

class DashboardViewController: UIViewController {
    
    

    var plusView:UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.8078431487, green: 0.02745098062, blue: 0.3333333433, alpha: 1)
        return view
        
    }()
    
    var name = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        let testViewController = EntryViewController()

        testViewController.userName = name
        setupTabBarController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    
  
}
