//
//  RenameCatalogueVC.swift
//  Emotipics
//
//  Created by Onqanet on 25/04/25.
//

import UIKit

class RenameCatalogueVC: UIViewController {
    
    
    
    
    @IBOutlet weak var renameCatalogueView: UIView!{
        didSet {
            renameCatalogueView.layer.cornerRadius = 25
            renameCatalogueView.clipsToBounds = true
        }
    }
    
    
    
    
    
    
    
    @IBOutlet weak var renameLbl: UILabel!
    
    
    
    
    @IBOutlet weak var catNameTxtFld: UITextField!{
        didSet{
            catNameTxtFld.layer.cornerRadius = 8
            catNameTxtFld.clipsToBounds = true
        }
    }
    
    
    
    
    
    @IBOutlet weak var submitBtn: UIButton!{
        didSet{
            submitBtn.layer.cornerRadius = 15
            submitBtn.clipsToBounds = true
        }
    }
    
    
    
    var folder_UUID: String = ""
    
    
    
    let catalogueRenameViewModel:CatalogueRenameViewModel = CatalogueRenameViewModel()
    
    let groupRenameViewModel: GroupRenameViewModel = GroupRenameViewModel()
    
    private var loaderView: ImageLoaderView?
    
    
    var groupCode: String = ""
    var renameGrp: Bool = false
    
    
    var onDismiss: (() -> Void)?

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        
        if renameGrp {
            renameLbl.text = "Rename Group"
            catNameTxtFld.placeholder = "Enter A New Group Name"
        }
    }
    
    
    
    
    
    @IBAction func cancelBtn(_ sender: Any) {
        
        self.dismiss(animated: true)
    }
    
    
    
    @IBAction func submitNewName(_ sender: Any) {
        
//        guard let newName = catNameTxtFld.text?.trimmingCharacters(in: .whitespacesAndNewlines), !newName.isEmpty else {
//            AlertView.showAlert("Warning!", message: "Enter A Valid Name", okTitle: "OK")
//            return
//        }
//        
//        catalogueRenameViewModel.requestModel.catUUID = folder_UUID
//        catalogueRenameViewModel.requestModel.newName = newName
//        
//        startCustomLoader()
//        catalogueRenameViewModel.catalogueRenameViewModel(request: catalogueRenameViewModel.requestModel) { result in
//            DispatchQueue.main.async {
//                //self.activityIndicator.stopAnimating()
//                self.stopCustomLoader()
//                switch result {
//                case .goAhead:
//                    print("Shared Catalogue View Model 🫡 🫡 View Controller")
//                    //table View Reload Data
//                    DispatchQueue.main.async { [self] in
//                        
//                        self.dismiss(animated: true)
//                        
//                    }
//                case .heyStop:
//                    print("Error")
//                }
//                
//                
//            }
//            
//            
//        }
        
        
        if renameGrp {
           // self.dismiss(animated: true)
            renameGroup()
        } else {
            renameCatalogue()
        }
        
        
    }
    
    func renameCatalogue(){
        
        guard let newName = catNameTxtFld.text?.trimmingCharacters(in: .whitespacesAndNewlines), !newName.isEmpty else {
            AlertView.showAlert("Warning!", message: "Enter A Valid Name", okTitle: "OK")
            return
        }
        
        catalogueRenameViewModel.requestModel.catUUID = folder_UUID
        catalogueRenameViewModel.requestModel.newName = newName
        
        startCustomLoader()
        catalogueRenameViewModel.catalogueRenameViewModel(request: catalogueRenameViewModel.requestModel) { result in
            DispatchQueue.main.async {
                //self.activityIndicator.stopAnimating()
                self.stopCustomLoader()
                switch result {
                case .goAhead:
                    print("Shared Catalogue View Model 🫡 🫡 View Controller")
                    //table View Reload Data
                    DispatchQueue.main.async { [self] in
                        
                        self.dismiss(animated: true)
                        
                    }
                case .heyStop:
                    print("Error")
                }
                
                
            }
            
            
        }
    }
    
    
    func renameGroup(){
        
        guard let newName = catNameTxtFld.text?.trimmingCharacters(in: .whitespacesAndNewlines), !newName.isEmpty else {
            AlertView.showAlert("Warning!", message: "Enter A Valid Name", okTitle: "OK")
            return
        }
        
        groupRenameViewModel.requestModel.groupCode = groupCode
        groupRenameViewModel.requestModel.groupName = newName
        
        startCustomLoader()
        groupRenameViewModel.groupRenameViewModel(request: groupRenameViewModel.requestModel) { result in
            DispatchQueue.main.async {
                //self.activityIndicator.stopAnimating()
                self.stopCustomLoader()
                switch result {
                case .goAhead:
                   print("Renamed Successful✅")
                    //table View Reload Data
                    
//                    DispatchQueue.main.async { [self] in
//                        
//                        self.dismiss(animated: true)
//                        
//                    }
                    
                    DispatchQueue.main.async { [self] in
                            self.onDismiss?()
                            self.dismiss(animated: true)
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
    
}
