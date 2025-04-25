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
    

    var onCopyConfirmed: (() -> Void)?

    
    var onMoveImageConfirmed: (() -> Void)?
    var onShareConfirmed: (() -> Void)?
    var delegate: DeleteImagePopUpDelegate?
    
    
    
    
    var imageId = 0
    var imageName = ""
    var imageSize = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped(_:)))
        view.addGestureRecognizer(tapGesture)
        
       
        
    }

    
    
    @IBAction func deleteImgDelete(_ sender: Any) {
        
        
        //delegate?.deleteImage()
        self.dismiss(animated: true) { [weak self] in
            self?.delegate?.deleteImage()
        }
    }
    

    @objc func backgroundTapped(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: self.view)
        
        // If tap is outside deleteCatalogPopUpView, dismiss
        if !fileInformationView.frame.contains(location) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    
    
    @IBAction func copyBtnAction(_ sender: Any) {
        
        if let button = sender as? UIButton {
            let title = button.title(for: .normal) ?? "No title"
            print("Button Title:", title)
            
            print("Action Type", title.lowercased())
            print("Image Id", imageId)
            print("Image Name", imageName )
            print("Image Size", imageSize)
        }
        
        
        self.dismiss(animated: true) { [weak self] in

            self?.onCopyConfirmed?()
            
        }
        
        
    }
    
    
    
    
    @IBAction func moveImage(_ sender: Any) {
        
        self.dismiss(animated: true) { [weak self] in

            self?.onMoveImageConfirmed?()
            
        }
        
    }
    
    
    
    
    @IBAction func shareImgAction(_ sender: Any) {
        

        self.dismiss(animated: true) { [weak self] in
            self?.onShareConfirmed?()
        }
        
    }
    
    
}



