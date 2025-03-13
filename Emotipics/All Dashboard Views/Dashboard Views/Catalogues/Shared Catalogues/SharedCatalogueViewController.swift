//
//  SharedCatalogueViewController.swift
//  Emotipics
//
//  Created by Onqanet on 13/03/25.
//

import UIKit

class SharedCatalogueViewController: UIViewController {
    
    

    @IBOutlet weak var roundedView: UIView!{
        didSet {
            roundedView.layer.cornerRadius = 35
            roundedView.clipsToBounds = true
        }
    }
    
    // table view
    
    
    @IBOutlet weak var sharedCollView: UICollectionView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        sharedCollView.dataSource = self
        sharedCollView.delegate = self
        
        sharedCollView.register(UINib(nibName: "EntryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
    }
}



extension SharedCatalogueViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 40
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! EntryCollectionViewCell
    
            cell.layer.cornerRadius = 15
            cell.clipsToBounds = true
        cell.sharedImgView.isHidden = false
        cell.sharedByLbl.isHidden = false
            return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
            return CGSize(width: 180, height: 150)
       
        
        //return CGSize(width: 180, height: 130)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        /* return UIEdgeInsets(top: 10, left: 0, bottom: 5, right: 5)*/ // Leading space for the first cell
        
        let totalCellWidth = 180 * 2 // Two cells per row, each 180 wide
        let totalSpacingWidth = 10 * 1 // One space between two cells
        let horizontalInset = (collectionView.frame.width - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
        return UIEdgeInsets(top: 10, left: horizontalInset, bottom: 10, right: horizontalInset)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10 // Adjust this value to decrease or increase spacing
    }
    
    
    
}
