//
//  NewCatalogueVC+CollectionViews.swift
//  Emotipics
//
//  Created by Onqanet on 16/05/25.
//

import Foundation
import UIKit





extension NewCatalogueVC: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout  {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
        if collectionView == catalogueCollView {
            return 10
        } else {
            return 12
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         
        if collectionView == catalogueCollView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewCatView", for: indexPath) as! NewCatCollViewCell
            cell.layer.cornerRadius = 20
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCataCell", for: indexPath) as! ImageCatalogueViewCell
            cell.layer.cornerRadius = 10
            cell.clipsToBounds = true
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == catalogueCollView {
            return CGSize(width: 200, height: collectionHeight)
        } else {
            let numberOfItemsPerRow: CGFloat = 2
          //  let spacingBetweenCells: CGFloat = 10
            let spacingBetweenCells: CGFloat = 8
            let sectionInsets: CGFloat = 8 // Reduced from 20 to avoid width issues
            
            let totalSpacing = (numberOfItemsPerRow - 1) * spacingBetweenCells + (sectionInsets * 2)
            let availableWidth = collectionView.bounds.width - totalSpacing
            
            //let cellWidth = availableWidth / numberOfItemsPerRow
            
            let cellWidth = (availableWidth / numberOfItemsPerRow) - 8
            
//                dynamicHeight = cellWidth * 1.0
//            return CGSize(width: max(0, cellWidth), height: cellWidth * 0.7)
            
            dynamicHeight = cellWidth * 1.0
        return CGSize(width: max(0, cellWidth), height: cellWidth * 0.6)
            
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == catalogueCollView {
            return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 65)
        } else {
            return UIEdgeInsets(top: 10, left: 15, bottom: 15, right: 15)
        }
        
    }
}
