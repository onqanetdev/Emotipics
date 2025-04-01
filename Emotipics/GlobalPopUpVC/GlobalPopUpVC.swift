//
//  GlobalPopUpVC.swift
//  Emotipics
//
//  Created by Onqanet on 01/04/25.
//

import UIKit

class GlobalPopUpVC: UIViewController {
    
    @IBOutlet weak var alertTitle: UILabel!
    
    
    @IBOutlet weak var msgTxtView: UITextView!
    
    

    
    @IBOutlet weak var okayBtn: UIButton!{
        didSet{
            okayBtn.layer.cornerRadius = 10
            okayBtn.clipsToBounds = true
        }
    }
    
    
    
    
    @IBOutlet weak var popUpView: UIView!{
        didSet{
            popUpView.layer.cornerRadius = 25
            popUpView.layer.borderWidth = 1
            popUpView.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1).cgColor
            popUpView.clipsToBounds = true
        }
    }
    
    var msgViewVar = " "
    
    
    
    @IBOutlet weak var popUpViewHeight: NSLayoutConstraint!
    
    
    @IBOutlet weak var msgTextViewHeight: NSLayoutConstraint!
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        msgTxtView.text = msgViewVar
        
        popUpViewHeight.constant = 200
        msgTextViewHeight.constant = 70
        
    }


    @IBAction func okBtnAction(_ sender: Any) {
        
        self.dismiss(animated: true)
        
    }
    
}
