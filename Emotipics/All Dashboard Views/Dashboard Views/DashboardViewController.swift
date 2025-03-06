//
//  DashboardViewController.swift
//  Emotipics
//
//  Created by Onqanet on 04/03/25.
//

import UIKit

class DashboardViewController: UIViewController {
    
    
    @IBOutlet weak var rotateBtn: UIButton!
    
    
    @IBOutlet weak var topView: UIView!
    
    
    
    @IBOutlet weak var welcomeBackLbl: UILabel!{
        didSet{
            //1.set the font family
            //2. May be need make two separate labels or '+' the existing name
            
        }
    }
    
    
    //The Oval Card
    
    @IBOutlet weak var cardView: UIView!{
        didSet{
            cardView.layer.cornerRadius = 25
            cardView.clipsToBounds = true
        }
    }
    
    
    @IBOutlet weak var CatalogueLbl: UILabel!{
        didSet{
            //1. set the font family for the label
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
//        rotateBtn.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        // Setup Tab Bar Controller
        setupTabBarController()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    
    @IBAction func allCatalogueAction(_ sender: Any) {
        
        //navigationController?.pushViewController(ExampleViewController(), animated: true)
        print("The Navigation is not working")
    }
    
    @IBAction func bellIconAction(_ sender: Any) {
        
        print("This is my bell Icon")
    }
    
}
