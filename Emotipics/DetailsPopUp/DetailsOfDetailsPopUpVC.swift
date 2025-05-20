//
//  DetailsOfDetailsPopUpVC.swift
//  Emotipics
//
//  Created by Onqanet on 15/05/25.
//

import UIKit

class DetailsOfDetailsPopUpVC: UIViewController {
    
    
    @IBOutlet weak var detailsView: UIView!{
        didSet{
            detailsView.layer.cornerRadius = 25
            detailsView.clipsToBounds = true
        }
    }
    
    
    
    
    @IBOutlet weak var groupNmLbl: UILabel!
    
    
    // MARK: All Labels
    
    
    @IBOutlet weak var grpNmLbl: UILabel!
    
    @IBOutlet weak var createdLbl: UILabel!
    
    @IBOutlet weak var ownerNmLbl: UILabel!
    
    @IBOutlet weak var totalUserLbl: UILabel!
    
    
    //MARK: All Label Variables
    
    var grpNmVar = ""
    var createdDateVar = ""
    var ownerNameVar = ""
    var totalUserVar = 0
    
    var catalogName = "Group Name"
    
    @IBOutlet weak var okBtn: UIButton!{
        didSet{
            okBtn.layer.cornerRadius = 10
            okBtn.clipsToBounds = true
        }
    }
    
    
    var onCompletion: (() -> Void)?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        grpNmLbl.text = grpNmVar
        ownerNmLbl.text = ownerNameVar
        totalUserLbl.text = String(totalUserVar)
        createdLbl.text = createdDateVar
        
        groupNmLbl.text = catalogName
    }


    
    
    @IBAction func dismissView(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    
    @IBAction func okDismiss(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
