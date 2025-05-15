//
//  DetailsVCPopUp.swift
//  Emotipics
//
//  Created by Onqanet on 15/05/25.
//

import UIKit

class DetailsVCPopUp: UIViewController {
    
    
    
    @IBOutlet weak var detailsBackGroundView: UIView!{
        didSet{
            detailsBackGroundView.layer.cornerRadius =  25
            detailsBackGroundView.clipsToBounds = true
        }
    }
    
    
    
    var onCompletion: (() -> Void)?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped(_:)))
        view.addGestureRecognizer(tapGesture)
    }
    
    
    @objc func backgroundTapped(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: self.view)
        
        // If tap is outside deleteCatalogPopUpView, dismiss
        if !detailsBackGroundView.frame.contains(location) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    
    @IBAction func nextViewController(_ sender: Any) {
        
//        self.navigationController?.pushViewController(DetailsOfDetailsPopUpVC(), animated: true)
        self.dismiss(animated: true) { [weak self] in
            
            print("View is getting dismissed")
                self?.onCompletion?()
            }
    }
    
    
    
    
    
}
