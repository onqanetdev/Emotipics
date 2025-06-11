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
            ImageViewBackground.layer.cornerRadius = 25
            ImageViewBackground.clipsToBounds = true
        }
    }
    
    
    
    @IBOutlet weak var partyImageView: UIImageView!{
        didSet {
            partyImageView.layer.cornerRadius = 15
            partyImageView.clipsToBounds = true
        }
    }
    
    
    @IBOutlet weak var downLoadBtn: UIButton!{
        didSet {
            downLoadBtn.layer.cornerRadius = 15
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
    
    
    
    @IBOutlet weak var selectEmojiBtn: UIButton!{
        didSet {
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
    
    
    
    func configureImage(urlString: String?, placeholder: String = "TopBackGround", ownerName: String?, emojis: [Emoji]?) {
        partyImageView.image = UIImage(named: placeholder)
        
        guard let urlString = urlString, let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data, error == nil else {
                print("Image download failed: \(urlString)")
                return
            }
            
            DispatchQueue.main.async { [weak self] in
                self?.partyImageView.image = UIImage(data: data)
                
                
                // Handle emoji rendering
                if let emojis = emojis {
                    if emojis.count <= 2 && emojis.count > 0 {
                        let emojiString = emojis.compactMap { $0.emoji_code }.joined()
                        self?.allEmojiBtn.setTitle(emojiString, for: .normal)
                    } else if emojis.count > 2 {
                        let preview = (emojis.prefix(2).compactMap { $0.emoji_code }).joined()
                        let summary = "\(preview)\(emojis.count - 2)+"
                        self?.allEmojiBtn.setTitle(summary, for: .normal)
                    } else {
                        self?.allEmojiBtn.setTitle("", for: .normal)
                    }
                }
            }
        }.resume()
    }
    
    
}
