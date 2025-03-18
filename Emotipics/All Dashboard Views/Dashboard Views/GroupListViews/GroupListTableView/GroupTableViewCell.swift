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
    
    
    @IBOutlet weak var userName: UILabel!

    @IBOutlet weak var noOfUsers: UILabel!
    
    @IBOutlet weak var daysLbl: UILabel!
    
    @IBOutlet weak var noOfCounts: UILabel!{
        didSet {
            noOfCounts.layer.cornerRadius = 15
            noOfCounts.clipsToBounds = true
        }
    }
    
    
    
    
    @IBOutlet weak var aboutBtn: UIButton!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        userName.font = UIFont(name: textInputStyle.latoBold.rawValue, size: 17)
        noOfUsers.font = UIFont(name: textInputStyle.poppinsRegular.rawValue, size: 12)
        daysLbl.font = UIFont(name: textInputStyle.poppinsRegular.rawValue, size: 12)
        noOfCounts.font = UIFont(name: textInputStyle.latoRegular.rawValue, size: 12)
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
