//
//  EntryTableViewCell.swift
//  Emotipics
//
//  Created by Onqanet on 06/03/25.
//

import UIKit

class EntryTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var cellView: UIView!{
        didSet {
            //1. Add the corner radius for the same
            cellView.layer.cornerRadius = 20
            cellView.clipsToBounds = true
        }
    }
    
    
    
    @IBOutlet weak var profilePhoto: UIImageView! {
        didSet{
            //1. Set corner radius for the profile photo
            
            
        }
    }
    
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
