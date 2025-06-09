//
//  GroupDetailOwnerViewCell.swift
//  Emotipics
//
//  Created by Onqanet on 09/06/25.
//

import UIKit

class GroupDetailOwnerViewCell: UITableViewCell {
    
    
    @IBOutlet weak var ImageViewBackground: UIView!{
        didSet {
            ImageViewBackground.layer.cornerRadius = 20
            ImageViewBackground.clipsToBounds = true
        }
    }
    
    
    
    @IBOutlet weak var partyImageView: UIImageView!{
        didSet {
            partyImageView.layer.cornerRadius = 10
            partyImageView.clipsToBounds = true
        }
    }
    
    
    @IBOutlet weak var downLoadBtn: UIButton!{
        didSet {
            downLoadBtn.layer.cornerRadius = 5
            downLoadBtn.clipsToBounds = true
        }
    }
    

    
    @IBOutlet weak var backGroundDeleteImgView: UIView!{
        didSet {
            backGroundDeleteImgView.layer.cornerRadius = 10
        }
    }
    
    
    
    @IBOutlet weak var deleteBtnAction: UIButton!
    
    
    
    
    
    
    @IBOutlet weak var sendingTime: UILabel!
    
    
    
    @IBOutlet weak var selectEmojiBtn: UIButton!
    
    
    @IBOutlet weak var allEmojiBtn: UIButton!
    
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
