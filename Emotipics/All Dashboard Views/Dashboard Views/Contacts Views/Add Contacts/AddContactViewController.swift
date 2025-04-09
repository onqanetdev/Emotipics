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
    
    var addCatalogueViewModel: AddCatalogueViewModel = AddCatalogueViewModel()
    
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
    
    
    
    @IBOutlet private weak var addCatLbl: UILabel!
    @IBOutlet private weak var createCataLbl: UILabel!{
        didSet {
            createCataLbl.numberOfLines = 2
            createCataLbl.textAlignment = .center
        }
    }
    @IBOutlet private weak var favImagesLbl: UILabel!
    
    
    //variables for updating  the texts
    var addCataText = ""
    var createCataTxt = ""
    var favImgLbl = ""
    var txtFieldPlaceHolder = ""
    
    var isCatalogueView:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupActivityIndicator()
        if isCatalogueView {
            addCatLbl.text = addCataText
            createCataLbl.text = createCataTxt
            favImagesLbl.text = favImgLbl
            emailTxtFld.placeholder = txtFieldPlaceHolder
            
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
    
    
    
    @IBAction func backBtnAction(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    
    

    @IBAction func saveIntoDatabase(_ sender: Any) {
        
        if isCatalogueView {
            
//            if let emailText = emailTxtFld.text , !emailText.isEmpty {
//                //AddCatalogueApiCaller.addCatalogueApiCaller(folderName: emailText)
//            } else {
//                AlertView.showAlert("Warning!", message: "Please Fill All The Details", okTitle: "OK")
//            }
            createNewCatalogue()
            
            
        } else {
            
            if let emailText = emailTxtFld.text , !emailText.isEmpty {
                activityIndicator.startAnimating()
                addConatctViewModel.requestModel.email = emailText
                addConatctViewModel.addContactViewModelfunc(request: addConatctViewModel.requestModel) { result in
                    
                    DispatchQueue.main.async{
                        self.activityIndicator.stopAnimating()
                        switch result {
                        case .goAhead:
                            
                            print("Its Okay")
                            self.emailTxtFld.text = ""
                            
                        case .heyStop:
                            print("SomeThing Went Wrong")
                        }
                        
                    }
                    
                }
                
            } else {
                AlertView.showAlert("Warning!", message: "Please Fill All The Details", okTitle: "OK")
            }
            
        } // else ending
        
    }
    

    
    func createNewCatalogue(){
        if let emailText = emailTxtFld.text , !emailText.isEmpty {
            addCatalogueViewModel.requestModel.folder_name = emailText
            addCatalogueViewModel.addCatalogueVM(request: addCatalogueViewModel.requestModel) { result in
                DispatchQueue.main.async {
                    self.activityIndicator.stopAnimating()
                    
                    switch result {
                    case .goAhead:
                        print("Success Folder Creation")
                        //table View Reload Data
                        DispatchQueue.main.async {
                            self.emailTxtFld.text = ""
                        }
                    case .heyStop:
                        print("Error")
                    }
                    
                    
                }
                
                
            }
        } else {
            AlertView.showAlert("Warning!", message: "Please Fill All The Details", okTitle: "OK")
        }
    }
    
    
}
