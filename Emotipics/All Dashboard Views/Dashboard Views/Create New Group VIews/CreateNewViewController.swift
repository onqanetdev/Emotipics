//
//  CreateNewViewController.swift
//  Emotipics
//
//  Created by Onqanet on 28/04/25.
//

import UIKit

class CreateNewViewController: UIViewController {
    
    
    
    @IBOutlet weak var backgroundImageView: UIView!{
        didSet {
            backgroundImageView.layer.cornerRadius = 35
            backgroundImageView.clipsToBounds = true
        }
    }
    
    
    
    @IBOutlet weak var grpNameTxtFld: UITextField!
    
    
    
    
    @IBOutlet weak var submitBtn: UIButton!{
        didSet{
            submitBtn.layer.cornerRadius = 15
            submitBtn.clipsToBounds = true
        }
    }
    
    
    
    var createGroupViewModel: CreateGroupViewModel = CreateGroupViewModel()
    
    
    private var loaderView: ImageLoaderView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    func createAGrp(groupName: String) {
        createGroupViewModel.requestModel.groupName = groupName
        
        //activityIndicator.startAnimating()
        startCustomLoader()
        
        createGroupViewModel.createGroupViewModel(request: createGroupViewModel.requestModel) { result in
            DispatchQueue.main.async { [self] in
                // self.activityIndicator.stopAnimating()
                stopCustomLoader()
                switch result {
                case .goAhead:
                    print("Hello")
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
    
    
    @IBAction func submitBtnAction(_ sender: Any) {
        
        guard let newName = grpNameTxtFld.text?.trimmingCharacters(in: .whitespacesAndNewlines), !newName.isEmpty else {
            // showAlertForEmptyName()
            AlertView.showAlert("Alert!", message: "Please Enter A Name", okTitle: "OK")
            return
        }
        
        createAGrp(groupName: newName)
        grpNameTxtFld.text = ""
        print("✔️ Done")
        
    }
    
    
    
    
    @IBAction func backAction(_ sender: Any) {
        
    
        navigationController?.popViewController(animated: true)
    }
}
