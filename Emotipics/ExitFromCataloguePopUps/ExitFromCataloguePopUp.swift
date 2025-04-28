//
//  ExitFromCataloguePopUp.swift
//  Emotipics
//
//  Created by Onqanet on 25/04/25.
//

import UIKit

class ExitFromCataloguePopUp: UIViewController {

    
    @IBOutlet weak var sharedCatInformationView: UIView!{
        didSet {
            sharedCatInformationView.layer.cornerRadius = 30
            sharedCatInformationView.clipsToBounds = true
        }
    }
    
    
    
    @IBOutlet weak var exitFromCatalogueBtn: UIButton!
    
    
    
    
    
    @IBOutlet weak var shareCatBtn: UIButton!
    
    
    
    var onExitFromCatalogue: (() -> Void)?
        var onShareCatalogue: (() -> Void)?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func dismissViewAction(_ sender: Any) {
        
        dismiss(animated: true)
        
    }
    
    
    
    @IBAction func exitCatalogue(_ sender: Any) {
        
        onExitFromCatalogue?()
        dismiss(animated: true)
        
    }
    
}






