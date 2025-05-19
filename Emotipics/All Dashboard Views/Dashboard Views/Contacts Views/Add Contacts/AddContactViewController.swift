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
    
//    var activityIndicator: UIActivityIndicatorView = {
//        let indicator = UIActivityIndicatorView(style: .large)
//        indicator.color = .systemOrange
//        indicator.hidesWhenStopped = true
//        return indicator
//    }()
    
    
    
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
    
    
    
    private var loaderView: ImageLoaderView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
       // setupActivityIndicator()
        if isCatalogueView {
            addCatLbl.text = addCataText
            createCataLbl.text = createCataTxt
            favImagesLbl.text = favImgLbl
            emailTxtFld.placeholder = txtFieldPlaceHolder
            
        }
    }

    
//    func setupActivityIndicator() {
//        view.addSubview(activityIndicator)
//        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
//        
//        activityIndicator.transform = CGAffineTransform(scaleX: 3.0, y: 3.0)
//        
//        NSLayoutConstraint.activate([
//            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
//        ])
//    }
    
    
    
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
                //activityIndicator.startAnimating()
                startCustomLoader()
                addConatctViewModel.requestModel.email = emailText
                addConatctViewModel.addContactViewModelfunc(request: addConatctViewModel.requestModel) { result in
                    
                    DispatchQueue.main.async{
                        //self.activityIndicator.stopAnimating()
                        self.stopCustomLoader()
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
                   // self.activityIndicator.stopAnimating()
                   
                    switch result {
                    case .goAhead:
                        print("Success Folder Creation")
                        //table View Reload Data
//                        DispatchQueue.main.async {
//                            self.emailTxtFld.text = ""
//                        }
                        
                        self.stopCustomLoader()
                        
                        DispatchQueue.main.async {
                            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                                  let window = windowScene.windows.first else {
                                return
                            }

                            let loginVC = EntryViewController() // Or instantiate from storyboard if needed
                            //loginVC.isSomeFieldsHidden = true
                            let nav = UINavigationController(rootViewController: loginVC)
                            nav.modalPresentationStyle = .fullScreen

                            window.rootViewController = nav
                            window.makeKeyAndVisible()
                        }
                        
                    case .heyStop:
                        print("Error")
                        
                        self.stopCustomLoader()
                    }
                    
                    
                }
                
                
            }
        } else {
            AlertView.showAlert("Warning!", message: "Please Fill All The Details", okTitle: "OK")
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
}
