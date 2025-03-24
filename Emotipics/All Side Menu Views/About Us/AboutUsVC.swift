//
//  AboutUsVC.swift
//  Emotipics
//
//  Created by Onqanet on 24/03/25.
//

import UIKit

class AboutUsVC: UIViewController {

    
    @IBOutlet weak var curvedBackGround: UIView!{
        didSet{
            curvedBackGround.layer.cornerRadius = 30
            curvedBackGround.clipsToBounds = true
        }
    }
    
    
    @IBOutlet weak var aboutusTitle: UILabel!
    
    @IBOutlet weak var aboutUsDetails: UITextView!
    
    
    
    var aboutUsTitleText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        aboutusTitle.font = UIFont(name: textInputStyle.latoBold.rawValue, size: 25)
        aboutUsDetails.font = UIFont(name: textInputStyle.poppinsRegular.rawValue, size: 15)
        
        aboutusTitle.text = aboutUsTitleText
        
        
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    
    @IBAction func backToPrevious(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        
    }
    
    
    
    
    
}
