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
    
    
    var loginViewModel:LoginViewModel = LoginViewModel()
    var registerViewModel:RegisterViewModel = RegisterViewModel()
    
    //let indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.large)
    
    var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .systemOrange
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        
        
        setupActivityIndicator()
        
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
        
        updateUIForState()
        
        loginViewModel.delegate = self
        registerViewModel.delegate = self
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        
    }
    
    
    
    func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        activityIndicator.transform = CGAffineTransform(scaleX: 3.0, y: 3.0)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
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
    // extra function
    func updateUIForState() {
        if isSomeFieldsHidden {
            fullNameTxtFld.isHidden = true
            phnTxtFld.isHidden = true
            fullNameHeight.constant = 0
            phnNumberHeight.constant = 0
            scrollView.isScrollEnabled = false
            welcomeLblSubOne.text = "Welcome back! Glad to see"
            welcomeLblSubTwo.text = "you again!"
            registerBtn.setTitle("Login", for: .normal)
            alreadyAccLbl.text = "Don't have an account?"
            loginlbl.text = "Register"
        } else {
            fullNameTxtFld.isHidden = false
            phnTxtFld.isHidden = false
            fullNameHeight.constant = 50
            phnNumberHeight.constant = 50
            scrollView.isScrollEnabled = true
            welcomeLblSubOne.text = "Create an Account"
            welcomeLblSubTwo.text = "Join us today!"
            registerBtn.setTitle("Register", for: .normal)
            alreadyAccLbl.text = "Already have an account?"
            loginlbl.text = "Login"
        }
        
        // Apply layout changes
        //        UIView.animate(withDuration: 0.3) {
        //            self.view.layoutIfNeeded()
        //        }
    }
    
    
    @objc func tapAction(){
        
        
        let registerVC = RegisterViewController() // Create a new instance
        
        if loginlbl.text == "Register" {
            registerVC.isSomeFieldsHidden = false // Set state for Register view
        } else {
            registerVC.isSomeFieldsHidden = true  // Set state for Login view
        }
        
        //Call The API through view model
        
        
        navigationController?.pushViewController(registerVC, animated: true)
        
        
        
    }
    
    //Calling for NSDataDetector for mail validation
    
    func isValidEmail(_ email: String) -> Bool {
        let detector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        let matches = detector?.matches(in: email, options: [], range: NSRange(location: 0, length: email.utf16.count))
        
        return matches?.contains(where: { $0.url?.scheme == "mailto" }) ?? false
    }
    
    
    
    @IBAction func registerBtnAction(_ sender: Any) {
        if loginlbl.text == "Register" {
            if let emailtext = emailAddTxtFld.text, !emailtext.isEmpty,
               let passwordText = passwordTxtFld.text, !passwordText.isEmpty {
                
                guard isValidEmail(emailtext) else {
                    showErrorPopup(message: "Please Enter Valid Credentials")
                    return
                }
                
                activityIndicator.startAnimating()
                registerBtn.isEnabled = false
                
                loginViewModel.requestModel.email = emailtext
                loginViewModel.requestModel.password = passwordText
                loginViewModel.getLoginData(loginViewModel.requestModel) { result in
                    DispatchQueue.main.async {
                        self.activityIndicator.stopAnimating()
                        self.registerBtn.isEnabled = true
                        
                        switch result {
                        case .goAhead:
                            self.navigationController?.pushViewController(DashboardViewController(), animated: true)
                        case .heyStop:
                            print("Something Went Wrong!!!")
                        }
                    }
                }
            } else {
                showErrorPopup(message: "Please Fill All The Boxes")
            }
        } else {
            print("This is my Register View")

            if let emailtext = emailAddTxtFld.text, !emailtext.isEmpty,
               let passwordText = passwordTxtFld.text, !passwordText.isEmpty,
               let nameText = fullNameTxtFld.text, !nameText.isEmpty,
               let phoneNumber = phnTxtFld.text, !phoneNumber.isEmpty {
                
                guard isValidEmail(emailtext) else {
                    showErrorPopup(message: "Please Enter A Valid Email ID")
                    return
                }
                
                // Name validation (only alphabets and spaces)
                let nameRegex = "^[A-Za-z ]+$"
                let namePredicate = NSPredicate(format: "SELF MATCHES %@", nameRegex)
                guard namePredicate.evaluate(with: nameText) else {
                    showErrorPopup(message: "Name must contain only alphabets and spaces")
                    return
                }
                
                // Phone number validation (must be exactly 10 digits)
                guard phoneNumber.count == 10, phoneNumber.allSatisfy({ $0.isNumber }) else {
                    showErrorPopup(message: "Phone number must be exactly 10 digits")
                    return
                }
                
                activityIndicator.startAnimating()
                registerBtn.isEnabled = false
                
                registerViewModel.requestModel.email = emailtext
                registerViewModel.requestModel.name = nameText
                registerViewModel.requestModel.password = passwordText
                registerViewModel.requestModel.phone = phoneNumber
                
                registerViewModel.registerNewUserViewModel(registerViewModel.requestModel) { result in
                    DispatchQueue.main.async {
                        self.activityIndicator.stopAnimating()
                        self.registerBtn.isEnabled = true
                    }
                    
                    switch result {
                    case .goAhead:
                        DispatchQueue.main.async {
                            self.navigationController?.pushViewController(DashboardViewController(), animated: true)
                        }
                    case .heyStop:
                        print("Something Went Wrong")
                    }
                }
            } else {
                showErrorPopup(message: "Please Fill All The Details")
            }
        }
    }
    
    
    func showErrorPopup(message: String) {
        let errorPopup = GlobalPopUpVC(nibName: "GlobalPopUpVC", bundle: nil)
        errorPopup.modalPresentationStyle = .overCurrentContext
        errorPopup.modalTransitionStyle = .crossDissolve
        errorPopup.msgViewVar = message
        self.present(errorPopup, animated: true)
    }
    
    @IBAction func backBtnAction(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func transparentBackBtn(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
    }
    
}


//MARK: Now this section is for delegate PopUpView

extension RegisterViewController: LoginViewModelDelegate {
    func presentPopup() {
        let errorPopup = GlobalPopUpVC(nibName: "GlobalPopUpVC", bundle: nil)
        errorPopup.modalPresentationStyle = .overCurrentContext
        errorPopup.modalTransitionStyle = .crossDissolve
        errorPopup.msgViewVar = "Please Enter Valid Credentials"  // Pass error message if needed
        self.present(errorPopup, animated: true)
    }
}

extension RegisterViewController: PopUpViewDelegate {
    func presentPopUp() {
        showErrorPopup(message: "Invalid Credentials")
    }
}
