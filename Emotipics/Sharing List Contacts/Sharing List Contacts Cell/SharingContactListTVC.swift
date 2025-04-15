//
//  SharingContactListTVC.swift
//  Emotipics
//
//  Created by Onqanet on 11/04/25.
//

import UIKit

class SharingContactListTVC: UITableViewCell {
    
    
    
    @IBOutlet weak var cellView: UIView!{
        didSet{
            cellView.layer.cornerRadius = 15
            cellView.clipsToBounds = true
        }
    }
    
    
    
    @IBOutlet weak var checkboxBtn: UIButton!
    
    @IBOutlet weak var contactLbl: UILabel!

    @IBOutlet weak var contactPhoto: UIImageView!
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    
    
    
    
    
    
}
