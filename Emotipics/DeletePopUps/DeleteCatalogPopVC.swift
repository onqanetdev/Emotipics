//
//  DeleteCatalogPopVC.swift
//  Emotipics
//
//  Created by Onqanet on 10/04/25.
//

import UIKit

class DeleteCatalogPopVC: UIViewController {
    
    
    var onCompletion: ((completeCases) -> Void)?
    
    @IBOutlet weak var deleteCatalogPopUpView: UIView!{
        didSet {
            deleteCatalogPopUpView.layer.cornerRadius = 25
            deleteCatalogPopUpView.clipsToBounds = true
        }
    }
    
    
    //weak var delegate: DeleteCatalogDelegate?
    
    
    var catalogData:[DataM] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped(_:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    
    @objc func backgroundTapped(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: self.view)
        
        // If tap is outside deleteCatalogPopUpView, dismiss
        if !deleteCatalogPopUpView.frame.contains(location) {
            self.dismiss(animated: true, completion: nil)
        }
    }

 
    
    @IBAction func deleteBtnAction(_ sender: Any) {
        print("✅ YES button tapped")
        if let onCompletion = onCompletion {
            print("✅ Closure exists, calling...")
            onCompletion(.YES)
        } else {
            print("❌ Closure is nil!")
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    func deleteCatalogGlobalPopUp() {
        let errorPopup = SharedInformationVC(nibName: "SharedInformationVC", bundle: nil)
        errorPopup.modalPresentationStyle = .overCurrentContext
        errorPopup.modalTransitionStyle = .crossDissolve
        errorPopup.delegate = self
        self.present(errorPopup, animated: true)
    }
    
    
    
    
    @IBAction func shareThis(_ sender: Any) {

        print("The Catalogue Data", catalogData)
        self.onCompletion?(.SHARE)
        
    }
    
    
    
    @IBAction func catalogueRename(_ sender: Any) {
        
        //print("Catalogue details-->", catalogData)
        self.onCompletion?(.RENAME)
        
    }
    
    
    
    @IBAction func detailsView(_ sender: Any) {
        self.onCompletion?(.DETAILS)
    }
    
    
    
}


extension DeleteCatalogPopVC: SharedInformationDelegate {
    func didTapProceed() {
        let vc = SharingContactListVC(nibName: "SharingContactListVC", bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
        
        
    }
}
