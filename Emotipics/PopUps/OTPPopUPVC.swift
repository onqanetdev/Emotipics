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
        if let otptext = otpTextField.text,
           !otptext.isEmpty {
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
}
