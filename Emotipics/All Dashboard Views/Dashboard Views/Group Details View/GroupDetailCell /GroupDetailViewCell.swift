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
    
    
    
    @IBOutlet weak var partyImageView: UIImageView! {
        didSet {
            partyImageView.layer.cornerRadius = 15
            
            partyImageView.clipsToBounds = true
        }
    }
    
    
    @IBOutlet weak var userName: UILabel!{
        didSet{
            userName.font = UIFont(name: textInputStyle.latoRegular.rawValue, size: 13)
        }
    }
    
    
    @IBOutlet weak var sendingTime: UILabel!{
        didSet{
            sendingTime.font = UIFont(name: textInputStyle.poppinsRegular.rawValue, size: 13)
        }
    }
    
    
    @IBOutlet weak var userProfilephoto: UIImageView!
    
    
    @IBOutlet weak var partyImgPhoto: UIImageView! {
        didSet{
            partyImgPhoto.layer.cornerRadius = 15
            partyImgPhoto.clipsToBounds = true
        }
    }
    
    
    @IBOutlet weak var downLoadBtn: UIButton!{
        didSet{
            downLoadBtn.layer.cornerRadius = 15
            downLoadBtn.clipsToBounds = true
            downLoadBtn.titleLabel?.font = UIFont(name: textInputStyle.latoRegular.rawValue, size: 14)
        }
    }
    
    
    @IBOutlet weak var photoIcon: UIImageView!{
        didSet{
            photoIcon.layer.cornerRadius = 15
            photoIcon.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var selectEmojiBtn: UIButton! {
        didSet{
            selectEmojiBtn.layer.cornerRadius = 8
            selectEmojiBtn.clipsToBounds = true
        }
    }
    
    
    
    @IBOutlet weak var allEmojiBtn: UIButton!{
        didSet {
            allEmojiBtn.layer.cornerRadius = 10
            allEmojiBtn.clipsToBounds = true
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
