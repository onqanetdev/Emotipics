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
    
    
    @IBOutlet weak var imageBtnDelete: UIButton!
    
    
    
    var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .systemTeal
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    private var loaderView: ImageLoaderView?
    
    
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


    func startCustomLoader(){
        //        let loaderSize: CGFloat = 220
        
        if loaderView != nil { return }
        let loader = ImageLoaderView(frame: self.bounds)
        loader.center = self.center
        loader.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        loader.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        //loader.layer.cornerRadius = 16
        
        self.addSubview(loader)
        loader.startAnimating()
        
        self.loaderView = loader
        
        // Stop and remove after 5 seconds
    }
    
    func stopCustomLoader(){
        print("Trying to stop loader:", loaderView != nil)
        loaderView?.stopAnimating()
        loaderView?.removeFromSuperview()
        
        loaderView = nil
        
        
    }
    
    
}
