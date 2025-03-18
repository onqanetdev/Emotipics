//
//  NotificationViewCell.swift
//  Emotipics
//
//  Created by Onqanet on 17/03/25.
//

import UIKit

class NotificationViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var imgView: UIView!{
        didSet{
            imgView.layer.cornerRadius = 15
            imgView.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var bellIcon: UIImageView!{
        didSet{
            bellIcon.layer.cornerRadius = 25
            bellIcon.clipsToBounds = true
        }
    }
    
    
    @IBOutlet weak var lblFirst: UILabel!
    
    @IBOutlet weak var lblSecond: UILabel!
    
    
    @IBOutlet weak var lblTime: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        lblFirst.font = UIFont(name: textInputStyle.latoRegular.rawValue, size: 16)
       // lblSecond.font = UIFont(name: textInputStyle.latoRegular.rawValue, size: 16)
        lblTime.font = UIFont(name: textInputStyle.latoRegular.rawValue, size: 12)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
