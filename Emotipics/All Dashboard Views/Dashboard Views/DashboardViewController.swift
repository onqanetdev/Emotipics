//
//  DashboardViewController.swift
//  Emotipics
//
//  Created by Onqanet on 04/03/25.
//

import UIKit

class DashboardViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = .systemCyan
        
        // Setup Tab Bar Controller
        setupTabBarController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
}
