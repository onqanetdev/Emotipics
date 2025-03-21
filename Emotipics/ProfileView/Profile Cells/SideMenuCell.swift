//
//  SideMenuCell.swift
//  Emotipics
//
//  Created by Onqanet on 21/03/25.
//

import UIKit

class SideMenuCell: UITableViewCell {
    
    
    
    @IBOutlet weak var imgViewTitle: UIImageView!
    
    
    @IBOutlet weak var myTitleLbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        myTitleLbl.font = UIFont(name: textInputStyle.latoRegular.rawValue, size: 18)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
