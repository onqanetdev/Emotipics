//
//  NewCatCollViewCell.swift
//  Emotipics
//
//  Created by Onqanet on 16/05/25.
//

import UIKit

class NewCatCollViewCell: UICollectionViewCell {

    
    @IBOutlet weak var mainView: UIView!{
        didSet {
            mainView.layer.cornerRadius = 20
            mainView.clipsToBounds = true
        }
    }
    
    
    
    @IBOutlet weak var shareByMeLbl: UILabel!{
        didSet{
            shareByMeLbl.isHidden = true
            
        }
    }
    
    
    @IBOutlet weak var personLbl: UIImageView!{
        didSet {
            personLbl.isHidden = true
        }
    }
    
    
    
    @IBOutlet weak var borderView: UIView!{
        didSet {
            borderView.isHidden = true
            borderView.clipsToBounds = true
        }
    }
    
    // MARK: All Labels
    
    @IBOutlet weak var projectFilesLbl: UILabel!
    
    @IBOutlet weak var noOfFiles: UILabel!
    
    @IBOutlet weak var availableSpaceDetails: UILabel!
    
    
    
    @IBOutlet weak var showFolder: UIImageView!


    @IBOutlet weak var moreFeaturesBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
