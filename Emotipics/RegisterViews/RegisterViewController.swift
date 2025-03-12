//
//  RegisterViewController.swift
//  Emotipics
//
//  Created by Onqanet on 03/03/25.
//

import UIKit

class RegisterViewController: UIViewController {
    
    
    @IBOutlet weak var welcomeLblSubOne: UILabel!{
        didSet{
            if let jostBold = UIFont(name: "Jost-Bold", size: welcomeLblSubOne.font.pointSize) {
                welcomeLblSubOne.font = jostBold
            } else {
                // Fallback if font isn't found
                print("Jost-Bold font not found")
            }
        }
    }
    
    @IBOutlet weak var welcomeLblSubTwo: UILabel!{
        didSet{
            if let jostBold = UIFont(name: "Jost-Bold", size: welcomeLblSubTwo.font.pointSize) {
                welcomeLblSubTwo.font = jostBold
            } else {
                // Fallback if font isn't found
                print("Jost-Bold font not found")
            }
        }
    }
    
    //MARK: All the properties for text fields
    
    
    @IBOutlet weak var fullNameTxtFld: UITextField!
    
    
    
    @IBOutlet weak var emailAddTxtFld: UITextField!
    
    
    
    @IBOutlet weak var phnTxtFld: UITextField!
    
    
    
    @IBOutlet weak var passwordTxtFld: UITextField!
    
    
    //MARK: Button properties settings
    
    
    @IBOutlet weak var registerBtn: UIButton!{
        didSet{
            registerBtn.layer.cornerRadius = 10
            registerBtn.clipsToBounds = true
            
            if let poppinsRegular = UIFont(name: "Poppins-Regular", size: 18.0) {
                registerBtn.titleLabel?.font = poppinsRegular
            } else {
                print("Poppins-Regular font not found")
            }
        }
    }
    
    
    
    
    @IBOutlet weak var loginlbl: UILabel!{
        didSet{
            if let poppinsRegular = UIFont(name: "Poppins-Medium", size: 15.0) {
                loginlbl.font = poppinsRegular
            } else {
                print("Poppins-Regular font not found")
            }
            loginlbl.isUserInteractionEnabled = true
            let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapAction))
            self.loginlbl.addGestureRecognizer(gestureRecognizer)
        }
    }
    
    
    @IBOutlet weak var alreadyAccLbl: UILabel!{
        didSet{
            if let poppinsRegular = UIFont(name: "Poppins-Regular", size: 15.0) {
                alreadyAccLbl.font = poppinsRegular
            } else {
                print("Poppins-Regular font not found")
            }
            
        }
    }
    
    
    
    @IBOutlet weak var backBtn: UIButton!{
        didSet {
                backBtn.frame = CGRect(x: 0, y: 0, width: 50, height: 50) // Increase button size
                backBtn.backgroundColor = .clear // Transparent background
                
                var config = UIButton.Configuration.plain()
                config.image = UIImage(systemName: "chevron.left.circle")?.withRenderingMode(.alwaysTemplate)
            config.baseForegroundColor = UIColor(red: 171/255, green: 210/255, blue: 252/255, alpha: 1.0).withAlphaComponent(0.2) // Lighter tint
            config.preferredSymbolConfigurationForImage = UIImage.SymbolConfiguration(pointSize: 28, weight: .light) // Increase image size
                
                backBtn.configuration = config
            }
        
    }
    
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    
    
    @IBOutlet weak var contentViewHeight: NSLayoutConstraint!
    
    
    @IBOutlet weak var fullNameHeight: NSLayoutConstraint!
    
    
    
    @IBOutlet weak var phnNumberHeight: NSLayoutConstraint!
    
    
    
    @IBOutlet weak var circleImage: UIImageView!
    
    
    
    
    var isSomeFieldsHidden: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        
        
        if let inputFont = UIFont(name: "Poppins-Regular", size: 16) {
            fullNameTxtFld.font = inputFont
            emailAddTxtFld.font = inputFont
            phnTxtFld.font = inputFont
            passwordTxtFld.font = inputFont
        } else {
            print("Poppins-Regular font not found")
        }
        
        
        let placeholderFont = UIFont(name: "Poppins-Regular", size: 13)
        let attributes: [NSAttributedString.Key: Any] = [
            .font: placeholderFont ?? UIFont.systemFont(ofSize: 13),
            .foregroundColor: UIColor.gray // You can set the color as well
        ]
        
        fullNameTxtFld.attributedPlaceholder = NSAttributedString(string: "Full Name", attributes: attributes)
        emailAddTxtFld.attributedPlaceholder = NSAttributedString(string: "Email Address", attributes: attributes)
        phnTxtFld.attributedPlaceholder = NSAttributedString(string: "Phone Number", attributes: attributes)
        passwordTxtFld.attributedPlaceholder = NSAttributedString(string: "Password", attributes: attributes)
        
        
        if isSomeFieldsHidden {
            fullNameTxtFld.isHidden = true
            phnTxtFld.isHidden = true
            //trying to minimizing the the height
            fullNameHeight.constant = 0
            phnNumberHeight.constant = 0
            scrollView.isScrollEnabled = false
          //  contentViewHeight.constant = -
            welcomeLblSubOne.text = "Welcome back! Glad to see"
            welcomeLblSubTwo.text = "you again!"
            registerBtn.titleLabel?.text = "Login"
            alreadyAccLbl.text = "Don't have an account?"
            loginlbl.text = "Register"
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Calculate the total height of all the UI elements
        let totalHeight = welcomeLblSubOne.frame.height +
        welcomeLblSubTwo.frame.height +
        fullNameTxtFld.frame.height +
        emailAddTxtFld.frame.height +
        phnTxtFld.frame.height +
        passwordTxtFld.frame.height +
        registerBtn.frame.height +
        alreadyAccLbl.frame.height
        
        
        contentViewHeight.constant = totalHeight + 320
        contentViewHeight.constant += 20
    }
    
    
    
    @objc func tapAction(){
        let registerVC = RegisterViewController()
        if let labeltitle = loginlbl.text {
            if labeltitle == "Register" {
                registerVC.isSomeFieldsHidden = false
                navigationController?.pushViewController(registerVC, animated: true)
            } else {
                registerVC.isSomeFieldsHidden = true
                //registerVC.registerBtn.titleLabel?.text = "Login"
                navigationController?.pushViewController(registerVC, animated: true)
            }
        }else {
            navigationController?.popViewController(animated: true)
        }
        
        
        //navigationController?.pushViewController(registerVC, animated: true)
        
    }
    
    
    
    @IBAction func registerBtnAction(_ sender: Any) {
        print("register Button ", loginlbl.text )
        
        navigationController?.pushViewController(DashboardViewController(), animated: true)
        print("The register button tapped")
        
    }
    
    
    @IBAction func backBtnAction(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func transparentBackBtn(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
    }
    
}

