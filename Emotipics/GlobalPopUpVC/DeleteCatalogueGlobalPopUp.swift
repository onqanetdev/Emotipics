//
//  DeleteCatalogueGlobalPopUp.swift
//  Emotipics
//
//  Created by Onqanet on 10/04/25.
//

import UIKit




enum completeCases {
    case YES
    case NO
    case SHARE
}







class DeleteCatalogueGlobalPopUp: UIViewController {

    
    
    @IBOutlet weak var deleteCatalogView: UIView!{
        didSet{
            deleteCatalogView.layer.cornerRadius = 20
            deleteCatalogView.clipsToBounds = true
        }
    }
    
    
    @IBOutlet weak var noBtn: UIButton!{
        didSet {
            noBtn.layer.cornerRadius = 10
            noBtn.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var yesBtn: UIButton!{
        didSet {
            yesBtn.layer.cornerRadius = 10
            yesBtn.clipsToBounds = true
        }
    }
    
    
    weak var delegate: DeleteCatalogDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.5)

        
        // Do any additional setup after loading the view.
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped(_:)))
        view.addGestureRecognizer(tapGesture)
    }


    @objc func backgroundTapped(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: self.view)
        
        // If tap is outside deleteCatalogPopUpView, dismiss
        if !deleteCatalogView.frame.contains(location) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
 
    
    
    

    @IBAction func noBtnAction(_ sender: Any) {
        print("Pressed on the no button")
//        delegate?.deletePopup()
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func yesBtnAction(_ sender: Any) {
        delegate?.deletePopup()
        self.dismiss(animated: true, completion: nil)
    }
    
}
