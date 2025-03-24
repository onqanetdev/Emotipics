//
//  NotificationDetailsVC.swift
//  Emotipics
//
//  Created by Onqanet on 24/03/25.
//

import UIKit

class NotificationDetailsVC: UIViewController {

    
    
    @IBOutlet weak var curvedBgView: UIView! {
        didSet {
            curvedBgView.layer.cornerRadius = 30
            curvedBgView.clipsToBounds = true
        }
    }
    
    
    @IBOutlet weak var notificationTitleLbl: UILabel!
    
    @IBOutlet weak var timingLbl: UILabel!

    @IBOutlet weak var contentTextView: UITextView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        notificationTitleLbl.font = UIFont(name: textInputStyle.latoBold.rawValue, size: 18)
        timingLbl.font = UIFont(name: textInputStyle.poppinsMedium.rawValue, size: 15)
        contentTextView.font = UIFont(name: textInputStyle.poppinsRegular.rawValue, size: 16)
        
        
    }


    
    @IBAction func previousView(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    

}
