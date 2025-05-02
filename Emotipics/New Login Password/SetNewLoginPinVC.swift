//
//  SetNewLoginPinVC.swift
//  Emotipics
//
//  Created by Onqanet on 01/05/25.
//

import UIKit

class SetNewLoginPinVC: UIViewController {

    
    @IBOutlet weak var newLoginPasswordView: UIView!{
        didSet{
            newLoginPasswordView.layer.cornerRadius = 30
            newLoginPasswordView.clipsToBounds = true
            
        }
    }
    
    
    
    
    @IBOutlet weak var enterEmailTextFld: UITextField!{
        didSet{
            enterEmailTextFld.layer.cornerRadius = 10
            enterEmailTextFld.clipsToBounds = true
        }
    }
    
    
    
    @IBOutlet weak var enterOtpFld: UITextField!{
        didSet {
            enterOtpFld.layer.cornerRadius = 10
            enterOtpFld.clipsToBounds = true
        }
    }
    
    
    @IBOutlet weak var enterNewPasswordTxtFld: UITextField! {
        didSet {
            enterNewPasswordTxtFld.layer.cornerRadius = 10
            enterNewPasswordTxtFld.clipsToBounds = true
        }
    }
    
    
    
    @IBOutlet weak var submitButton: UIButton!{
        didSet{
            submitButton.layer.cornerRadius = 15
            submitButton.clipsToBounds = true
        }
    }
    
    
    var resetPasswordViewModel: ResetPasswordViewModel = ResetPasswordViewModel()
    
    private var loaderView: ImageLoaderView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


  

    
    
    @IBAction func dismissView(_ sender: Any) {
        
        self.dismiss(animated: true)
    }
    
    
    func resetPasswordsCaller() {
        
        guard let emailText = enterEmailTextFld.text?.trimmingCharacters(in: .whitespacesAndNewlines), !emailText.isEmpty,
              let otpField = enterOtpFld.text?.trimmingCharacters(in: .whitespacesAndNewlines), !otpField.isEmpty,
              let passwordField = enterNewPasswordTxtFld.text?.trimmingCharacters(in: .whitespacesAndNewlines), !passwordField.isEmpty
                
        else {
            AlertView.showAlert("Warning!", message: "Enter An Email", okTitle: "OK")
            return
        }
        
        resetPasswordViewModel.requestModel.email = emailText
        resetPasswordViewModel.requestModel.otp = otpField
        resetPasswordViewModel.requestModel.password = passwordField
       
        
        startCustomLoader()
        resetPasswordViewModel.resetPasswordViewModel(request: resetPasswordViewModel.requestModel) { result in
            DispatchQueue.main.async {
                //self.activityIndicator.stopAnimating()
                self.stopCustomLoader()
                switch result {
                case .goAhead:
                   print("Email Sent Successful✅")
                    //table View Reload Data

                    
                    DispatchQueue.main.async { [weak self] in
                        self?.dismiss(animated: true) {
                            print("Dismiss complete for set new pin")
                            //self?.onForgetPassword?()
                        }
                    }
                    
                case .heyStop:
                    print("Error")
                }
                
                
            }
            
            
        }
    }
    
    
    func startCustomLoader(){
        //        let loaderSize: CGFloat = 220
        
        if loaderView != nil { return }
        let loader = ImageLoaderView(frame: view.bounds)
        loader.center = view.center
        loader.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        loader.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        //loader.layer.cornerRadius = 16
        
        view.addSubview(loader)
        loader.startAnimating()
        
        self.loaderView = loader
        
        // Stop and remove after 5 seconds
    }
    
    func stopCustomLoader(){
        print("Trying to stop loader:", loaderView != nil)
        loaderView?.stopAnimating()
        loaderView?.removeFromSuperview()
        
        loaderView = nil
        
        
    }
    
    
    
    @IBAction func onSubmit(_ sender: Any) {
        
        resetPasswordsCaller()
        
    }
    
    
}
