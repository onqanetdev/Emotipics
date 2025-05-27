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
    
    
    @IBOutlet weak var birthdayMsgTxtField: UITextView!{
        didSet {
            birthdayMsgTxtField.layer.cornerRadius = 10
            birthdayMsgTxtField.clipsToBounds = true
        }
    }
        
    var onCompletion: ((String) -> Void)?

    
    let placeholderText = "Enter birthday message here..."
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        birthdayMsgTxtField.delegate = self
        setupPlaceholder()
    }

    
    func setupPlaceholder() {
            birthdayMsgTxtField.text = placeholderText
            birthdayMsgTxtField.textColor = .lightGray
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




extension BirthdayPopUpView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == placeholderText {
            textView.text = ""
            textView.textColor = .black
        }
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            setupPlaceholder()
        }
    }
}

