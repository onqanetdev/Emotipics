//
//  GroupDetailViewCell.swift
//  Emotipics
//
//  Created by Onqanet on 18/03/25.
//

import UIKit

class GroupDetailViewCell: UITableViewCell {

    @IBOutlet weak var ImageViewBackground: UIView!{
        didSet {
            ImageViewBackground.layer.cornerRadius = 25
            ImageViewBackground.clipsToBounds = true
        }
    }
    
    
    
    @IBOutlet weak var partyImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
