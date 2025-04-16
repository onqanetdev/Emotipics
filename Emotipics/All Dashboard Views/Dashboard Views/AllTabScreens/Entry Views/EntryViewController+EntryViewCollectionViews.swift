//
//  EntryViewController+EntryViewCollectionViews.swift
//  Emotipics
//
//  Created by Onqanet on 06/03/25.
//

import Foundation
import UIKit




extension EntryViewController: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return 4
        //catalogueListingViewModel.responseModel?.data?.count ?? 4
        return tempMemory.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! EntryCollectionViewCell
        cell.layer.cornerRadius = 25


        
        
        cell.projectFilesLbl.text = tempMemory[indexPath.row].catalog_name
        cell.noOfFiles.text = tempMemory[indexPath.row].total_files
        cell.fiveGbLbl.text = tempMemory[indexPath.row].file_storage
        
        cell.moreFeaturesBtn.tag = indexPath.row
        cell.moreFeaturesBtn.addTarget(self, action: #selector(deleteCatalogueBtnAction(_:)), for: .touchUpInside)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: collectionHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 65) // Leading space for the first cell
        }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let imageViewController = AllCataloguesViewController()
        imageViewController.isImageCell = true
    
//        let catalogueId = catalogueListingViewModel.responseModel?.data?[indexPath.row].catalog_code
//            let userCode = catalogueListingViewModel.responseModel?.data?[indexPath.row].owner_detials?.code
        
        let catalogueId = tempMemory[indexPath.row].catalog_code
        let userCode = tempMemory[indexPath.row].owner_detials?.code
        //Temp catalogue
        let tappedCatalogueName = tempMemory[indexPath.row].catalog_name
        
        print("Requirements👉🏾👉🏾👉🏾👉🏾👉🏾👉🏾👉🏾👉🏾catalogue Code \(catalogueId ?? "No String") Catalogue Name \(tappedCatalogueName)")
        
        if let catalogueId = catalogueId {
            UserDefaults.standard.set(catalogueId, forKey: "catalogueId")
        }

        if let userCode = userCode {
            UserDefaults.standard.set(userCode, forKey: "userCode")
        }
        
        
        navigationController?.pushViewController(imageViewController, animated: true)
    }
}
