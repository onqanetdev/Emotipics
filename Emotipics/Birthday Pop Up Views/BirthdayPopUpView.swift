//
//  BirthdayPopUpView.swift
//  Emotipics
//
//  Created by Onqanet on 23/05/25.
//

import UIKit

class BirthdayPopUpView: UIViewController {

    
    
    
    @IBOutlet weak var submitBtn: UIButton!{
        didSet {
            submitBtn.layer.cornerRadius = 15
            submitBtn.clipsToBounds = true
            submitBtn.layer.borderWidth = 1
            submitBtn.layer.borderColor = #colorLiteral(red: 0.007843137255, green: 0.3176470588, blue: 0.6549019608, alpha: 1)
        }
    }
    
    
    
    @IBOutlet weak var backGroundView: UIView!{
        didSet{
            backGroundView.layer.cornerRadius = 25
            backGroundView.clipsToBounds = true
        }
    }
    
    
    @IBOutlet weak var birthdayMsgTxtField: UITextField!
    
    
    
    //var onCompletion:((birthDayMsg:String) -> Void)?
    
    var onCompletion: ((String) -> Void)?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    
    @IBAction func submitBtnAction(_ sender: Any) {
        
       // print("Birthday Msg is -->", birthdayMsgTxtField.text)
        
        guard let message = birthdayMsgTxtField.text, !message.isEmpty else {
                return
            }
            print("Birthday Msg is -->", message)
            onCompletion?(message)
            self.dismiss(animated: true, completion: nil)
        
        
    }
    
}
