//
//  GroupTableViewCell.swift
//  Emotipics
//
//  Created by Onqanet on 17/03/25.
//

import UIKit

class GroupTableViewCell: UITableViewCell {

    
    
    @IBOutlet weak var backGrdView: UIView!{
        didSet {
            backGrdView.layer.cornerRadius  = 25
            backGrdView.clipsToBounds = true
        }
    }
    
    
    
    @IBOutlet weak var imageViewGroup: UIImageView!{
        didSet{
            imageViewGroup.layer.cornerRadius = 25
            imageViewGroup.clipsToBounds = true
        }
    }
    
    
    @IBOutlet weak var grpName: UILabel!

    @IBOutlet weak var noOfUsers: UILabel!
    
    @IBOutlet weak var daysLbl: UILabel!
    
    @IBOutlet weak var aboutBtn: UIButton!
    
    var uploadedDays = ""
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        grpName.font = UIFont(name: textInputStyle.latoBold.rawValue, size: 17)
        noOfUsers.font = UIFont(name: textInputStyle.poppinsRegular.rawValue, size: 12)
        daysLbl.font = UIFont(name: textInputStyle.poppinsRegular.rawValue, size: 12)
//        noOfCounts.font = UIFont(name: textInputStyle.latoRegular.rawValue, size: 12)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
