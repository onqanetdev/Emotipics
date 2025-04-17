//
//  ImageDeletePopUpVC.swift
//  Emotipics
//
//  Created by Onqanet on 16/04/25.
//

import UIKit

class ImageDeletePopUpVC: UIViewController {
    
    
    
    @IBOutlet weak var fileInformationView: UIView!{
        didSet {
            fileInformationView.layer.cornerRadius = 25
            fileInformationView.clipsToBounds = true
        }
    }
    
    
    @IBOutlet weak var imgDeleteBtn: UIButton!
    

    
    var delegate: DeleteImagePopUpDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped(_:)))
        view.addGestureRecognizer(tapGesture)
    }

    
    
    @IBAction func deleteImgDelete(_ sender: Any) {
        
        //print("Hello")
        delegate?.deleteImage()
    }
    

    @objc func backgroundTapped(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: self.view)
        
        // If tap is outside deleteCatalogPopUpView, dismiss
        if !fileInformationView.frame.contains(location) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
}
