//
//  PlusIconViewController.swift
//  Emotipics
//
//  Created by Onqanet on 13/06/25.
//

import UIKit

class PlusIconViewController: UIViewController {
    
    
    
    @IBOutlet weak var createCatalogueBtn: UIButton!{
        didSet {
            createCatalogueBtn.layer.cornerRadius = 22
            createCatalogueBtn.clipsToBounds = true
        }
    }
    
    
    @IBOutlet weak var createGroupsBtn: UIButton!{
        didSet {
            createGroupsBtn.layer.cornerRadius = 20
            createGroupsBtn.clipsToBounds = true
        }
    }
    
    

    
    @IBOutlet weak var addContactsBtn: UIButton!{
        didSet {
            addContactsBtn.layer.cornerRadius = 20
            addContactsBtn.clipsToBounds = true
        }
    }
    
    
    
    
    @IBOutlet weak var stackViewContainer: UIStackView!
    
    
    var onTappingAdd:(() -> Void)?
    
    var onTappingCreateGrp: (() -> Void)?
    
    var onTappingCreateCatalog: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self.view)
        
        if !stackViewContainer.frame.contains(location) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    @IBAction func createCatalogueAction(_ sender: Any) {
        //onTappingCreateCatalog?()
        
        self.dismiss(animated: true) {
            self.onTappingCreateCatalog?()
        }
        
    }
    
    
    
    
    @IBAction func createGroupAction(_ sender: Any) {
        
        self.dismiss(animated: true) {
            self.onTappingCreateGrp?()
        }
    }
    

    
    @IBAction func addContactsAction(_ sender: Any) {

        self.dismiss(animated: true) {
            self.onTappingAdd?()
        }
        
        
        
    }
    
    
}
