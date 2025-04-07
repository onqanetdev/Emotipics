//
//  AddContactViewController.swift
//  Emotipics
//
//  Created by Onqanet on 04/04/25.
//

import UIKit

class AddContactViewController: UIViewController {

    
    @IBOutlet weak var backgroundImageView: UIView! {
        didSet {
            backgroundImageView.layer.cornerRadius = 35
            backgroundImageView.clipsToBounds = true
        }
    }
    
    
    
    
    @IBOutlet weak var emailTxtFld: UITextField! {
        didSet {
            emailTxtFld.layer.cornerRadius = 12
            emailTxtFld.clipsToBounds = true
        }
    }
    
    var addConatctViewModel: AddContactViewModel = AddContactViewModel()
    
    
    var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .systemOrange
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    
    
    @IBOutlet weak var submitBtn: UIButton!{
        didSet {
            submitBtn.layer.cornerRadius = 15
            submitBtn.clipsToBounds = true
        }
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupActivityIndicator()
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
    
    
    
    @IBAction func backBtnAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    
    

    @IBAction func saveIntoDatabase(_ sender: Any) {
        
        
        if let emailText = emailTxtFld.text , !emailText.isEmpty {
            activityIndicator.startAnimating()
            addConatctViewModel.requestModel.email = emailText
            addConatctViewModel.addContactViewModelfunc(request: addConatctViewModel.requestModel) { result in
                
                DispatchQueue.main.async{
                    self.activityIndicator.stopAnimating()
                    switch result {
                    case .goAhead:
                        
                        print("Its Okay")
                        
                    case .heyStop:
                        print("SomeThing Went Wrong")
                    }
                    
                }
                
            }
            
        } else {
            AlertView.showAlert("Warning!", message: "Please Fill All The Details", okTitle: "OK")
        }
        
    }
    

}
