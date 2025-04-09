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
        catalogueListingViewModel.responseModel?.data?.count ?? 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! EntryCollectionViewCell
        cell.layer.cornerRadius = 25

        if let data = catalogueListingViewModel.responseModel?.data, indexPath.row < data.count {
            let item = data[indexPath.row]
            cell.projectFilesLbl.text = item.catalog_name ?? "Nil"
            cell.noOfFiles.text = item.total_files ?? "Nil"
            cell.fiveGbLbl.text = item.file_storage ?? "Nil"
        } else {
            // Default values for safety
            cell.projectFilesLbl.text = "No Name"
            cell.noOfFiles.text = "0 Files"
            cell.fiveGbLbl.text = "0 GB"
        }
        
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
    
//        print("Tapped On The Cell",catalogueListingViewModel.responseModel?.data?[indexPath.row].catalog_name, "Catalogue id is", catalogueListingViewModel.responseModel?.data?[indexPath.row].catalog_code)
//        print("User Id is ", catalogueListingViewModel.responseModel?.data?[indexPath.row].owner_detials?.code)
        
        let catalogueId = catalogueListingViewModel.responseModel?.data?[indexPath.row].catalog_code
            let userCode = catalogueListingViewModel.responseModel?.data?[indexPath.row].owner_detials?.code
        
        
        
        if let catalogueId = catalogueId {
            UserDefaults.standard.set(catalogueId, forKey: "catalogueId")
        }

        if let userCode = userCode {
            UserDefaults.standard.set(userCode, forKey: "userCode")
        }
        
        
        navigationController?.pushViewController(imageViewController, animated: true)
    }
}
