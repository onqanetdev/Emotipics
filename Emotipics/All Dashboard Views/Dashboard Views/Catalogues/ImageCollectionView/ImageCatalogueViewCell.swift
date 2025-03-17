//
//  ImageCatalogueViewCell.swift
//  Emotipics
//
//  Created by Onqanet on 17/03/25.
//

import UIKit

class ImageCatalogueViewCell: UICollectionViewCell {

    
    @IBOutlet weak var imgViewColl: UIImageView!{
        didSet{
            imgViewColl.layer.cornerRadius = 15
        }
    }
    
    
    
    @IBOutlet weak var imageTitle: UILabel!{
        didSet{
            imageTitle.font = UIFont(name: textInputStyle.latoRegular.rawValue, size: 13)
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
