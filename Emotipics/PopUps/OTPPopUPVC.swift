//
//  OTPPopUPVC.swift
//  Emotipics
//
//  Created by Onqanet on 02/04/25.
//

import UIKit

class OTPPopUPVC: UIViewController {

    
    
    @IBOutlet weak var backGroundView: UIView!{
        didSet {
            backGroundView.layer.cornerRadius = 15
            backGroundView.clipsToBounds = true
            backGroundView.layer.borderWidth = 1
            backGroundView.layer.borderColor = UIColor.gray.cgColor
        }
    }
    
    
    
    
    
    
    
    @IBOutlet weak var nextbtn: UIButton!{
        didSet {
            nextbtn.layer.cornerRadius = 15
            nextbtn.clipsToBounds = true
        }
    }
    
    
    
    @IBOutlet weak var otpTextField: UITextField!
    
    
    
    @IBOutlet weak var emailVerifyTxtFld: UILabel!
    
    var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .systemOrange
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    
    var otpViewModel: OTPViewModel = OTPViewModel()
    
    var emailText: String = ""
    var isOtpScreen:Bool = false
    
    var loginPinViewModel: LoginSetPinViewModel = LoginSetPinViewModel()
    
    weak var delegate:MoveToNextView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupActivityIndicator()
    }


    
    func updateUI(){
        
        
        emailVerifyTxtFld.text = "Setup A Login PIN"
        otpTextField.placeholder = "Enter Login PIN"
        nextbtn.setTitle("SUBMIT", for: .normal)
        otpTextField.text = ""
        isOtpScreen = true
    
    }
    
    func showPinScreen() {
        if let otptext = otpTextField.text,
           !otptext.isEmpty {
            print("MY PIN IS", otptext)
            //LoginPinSetAPICaller.userPinSet(pin: otptext, email: emailText)
            
            
            if otptext.count < 4 {
                    AlertView.showAlert("Warning!!", message: "PIN must be at least 4 Digits", okTitle: "OK")
                    return
                }

                if otptext.count > 4 {
                    AlertView.showAlert("Warning!!", message: "PIN must not exceed 4 Digits", okTitle: "OK")
                    return
                }
            
            
            
            activityIndicator.startAnimating()
            loginPinViewModel.requestModel.pin = otptext
            loginPinViewModel.requestModel.email = emailText
            loginPinViewModel.loginSetPinNew(request: loginPinViewModel.requestModel) { result in
                
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    
                    switch result {
                    case .goAhead:
                        print("GO Ahead")
                        DispatchQueue.main.async {
                            //self.updateUI()
                            //print("")
                            self.delegate?.nextToMove()
                            self.dismiss(animated: true)
//                            self.navigationController?.pushViewController(DashboardViewController(), animated: true)
                        }
                    case .heyStop:
                        print("Something Went Wrong")
                    }
                }
            }
            
            
            
            
        } else {
            AlertView.showAlert("Warning!", message: "Please Fill The Field", okTitle: "OK")
        }
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
    
    
    
    @IBAction func verificationBtnAction(_ sender: Any) {
        
        
        if isOtpScreen == true {
            showPinScreen()
        } else {
            
            
            if let otptext = otpTextField.text,
               !otptext.isEmpty {
                
                
                if otptext.count < 4 {
                        AlertView.showAlert("Warning!!", message: "OTP must be at least 4 characters long", okTitle: "OK")
                        return
                    }

                    if otptext.count > 4 {
                        AlertView.showAlert("Warning!!", message: "OTP must not exceed 4 characters", okTitle: "OK")
                        return
                    }
                
                
                activityIndicator.startAnimating()
                
                otpViewModel.requestModel.email = emailText
                otpViewModel.requestModel.otp = otptext
                otpViewModel.otpVerification(request: otpViewModel.requestModel) { result in
                    
                    DispatchQueue.main.async {
                        self.activityIndicator.stopAnimating()
                        
                        switch result {
                        case .goAhead:
                            print("Success")
                            DispatchQueue.main.async {
                                self.updateUI()
                            }
                        case .heyStop:
                            print("Something Went Wrong")
                        }
                    }
                }
            }
            
            else {
                AlertView.showAlert("Warning!!", message: "Please Enter The OTP", okTitle: "OK")
            }
            
        }
        
    } // Ib action
}
