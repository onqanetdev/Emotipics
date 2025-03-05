//
//  HomeViewController.swift
//  Emotipics
//
//  Created by Onqanet on 03/03/25.
//

import UIKit

class HomeViewController: UIViewController {
    
    
    @IBOutlet weak var loginBtn: UIButton!{
        didSet{
            loginBtn.layer.cornerRadius = 12
            loginBtn.layer.borderWidth = 1
            loginBtn.layer.borderColor = #colorLiteral(red: 0.6705882353, green: 0.8235294118, blue: 0.9843137255, alpha: 1).cgColor
            loginBtn.clipsToBounds = true
        }
    }
    
    
    @IBOutlet weak var registerbtn: UIButton!{
        didSet{
            registerbtn.layer.cornerRadius = 15
            registerbtn.clipsToBounds = true
        }
    }
    
    
    @IBOutlet weak var welcomeLbl: UILabel!{
        didSet {
            if let jostBold = UIFont(name: "Jost-Bold", size: welcomeLbl.font.pointSize) {
                        welcomeLbl.font = jostBold
                    } else {
                        // Fallback if font isn't found
                        print("Jost-Bold font not found")
                    }
        }
    }
    
    
    @IBOutlet weak var subWelcomelbl: UILabel!{
        didSet {
            if let poppinsMedium = UIFont(name: "Poppins-Regular", size: subWelcomelbl.font.pointSize) {
                subWelcomelbl.font = poppinsMedium
                    } else {
                        // Fallback if font isn't found
                        print("Poppins-Regular font not found")
                    }
        }
    }
    
    
    @IBOutlet weak var subWelcomeLblTwo: UILabel!{
        didSet {
            if let poppinsMedium = UIFont(name: "Poppins-Regular", size: subWelcomeLblTwo.font.pointSize) {
                subWelcomeLblTwo.font = poppinsMedium
                    } else {
                        // Fallback if font isn't found
                        print("Poppins-Regular font not found")
                    }
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        
        
    }
    
    
    
    
    @IBAction func loginBtnAction(_ sender: Any) {
        print("Tapped on login")
        let loginView = RegisterViewController()
        loginView.isSomeFieldsHidden = true
        navigationController?.pushViewController(loginView, animated: true)
        
    }
    
    
    @IBAction func registerBtnAction(_ sender: Any) {
        print("Tapped on Register")
        navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
    
}
