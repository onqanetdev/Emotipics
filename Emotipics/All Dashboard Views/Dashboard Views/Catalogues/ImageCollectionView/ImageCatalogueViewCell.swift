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
            imgViewColl.layer.cornerRadius = 13
        }
    }
    
    
    
    @IBOutlet weak var imageTitle: UILabel!{
        didSet{
            imageTitle.font = UIFont(name: textInputStyle.latoRegular.rawValue, size: 13)
        }
    }
    
    
    
    var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .systemTeal
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupActivityIndicator()
    }
    
    
    
    func setupActivityIndicator() {
        contentView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }


}
