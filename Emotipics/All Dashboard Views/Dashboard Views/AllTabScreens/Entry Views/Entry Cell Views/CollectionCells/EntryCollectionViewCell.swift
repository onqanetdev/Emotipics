//
//  EntryCollectionViewCell.swift
//  Emotipics
//
//  Created by Onqanet on 06/03/25.
//

import UIKit

class EntryCollectionViewCell: UICollectionViewCell {

    
    
    
    
    @IBOutlet weak var projectFilesLbl: UILabel!{
        didSet {
            projectFilesLbl.font = UIFont(name: textInputStyle.latoBold.rawValue, size: 12)
        }
    }
    
    
    
    @IBOutlet weak var noOfFiles: UILabel!{
        didSet {
            noOfFiles.font = UIFont(name: textInputStyle.poppinsRegular.rawValue, size: 14)
        }
    }
    
    
    
    @IBOutlet weak var fiveGbLbl: UILabel!{
        didSet {
            fiveGbLbl.font = UIFont(name: textInputStyle.poppinsMedium.rawValue, size: 11)
        }
    }
    
    
    @IBOutlet weak var sharedImgView: UIImageView!
    
    
    @IBOutlet weak var sharedByLbl: UILabel!{
        didSet {
            sharedByLbl.font = UIFont(name: textInputStyle.latoRegular.rawValue, size: 14)
        }
    }
    
    
    
    @IBOutlet weak var moreFeaturesBtn: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        sharedImgView.isHidden = true
        sharedByLbl.isHidden = true
    }
    
    
    @IBAction func testBtn(_ sender: Any) {
        
        print("Testing")
    }
    
}
