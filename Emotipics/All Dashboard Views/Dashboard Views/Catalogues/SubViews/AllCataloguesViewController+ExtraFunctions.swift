//
//  AllCataloguesViewController+ExtraFunctions.swift
//  Emotipics
//
//  Created by Onqanet on 16/04/25.
//

import Foundation
import UIKit


extension AllCataloguesViewController: DeleteImagePopUpDelegate {
    @objc func deleteImage(_ sender: UIButton){
         imageIndex = sender.tag
        print("The Index at desire index", imageCount[imageIndex].id as Any)
        if let img = imageCount[imageIndex].id {
            imageCode = img
        } else {
           print("There is no image Code ")
        }
        
        
        
        deleteImagePopUp()
    }
    
    
    func deleteImagePopUp() {
        let errorPopup = ImageDeletePopUpVC(nibName: "ImageDeletePopUpVC", bundle: nil)
        
        errorPopup.modalPresentationStyle = .overCurrentContext
        errorPopup.modalTransitionStyle = .crossDissolve
    
        errorPopup.delegate = self
        
        
//        print("Image id-->", imageCount[imageIndex].id)
//        print("Image Name-->", imageCount[imageIndex].img_name)
//        print("Image Size--->", imageCount[imageIndex].image_size)
        
        
        if let imageIde = imageCount[imageIndex].id, let imageName = imageCount[imageIndex].img_name, let imageSize = imageCount[imageIndex].image_size {
            
            
            errorPopup.imageId = imageIde
            errorPopup.imageName = imageName
            errorPopup.imageSize = imageSize
            
            
            
        } else {
            
        }
        
        errorPopup.onCopyConfirmed = { [weak self] in
            // Navigate or handle logic when "Copy" is tapped
            let copyVC = CopyMoveViewController()
            copyVC.imageId = errorPopup.imageId
            copyVC.imageName = errorPopup.imageName
            copyVC.imageSize = errorPopup.imageSize
            copyVC.typeOfAction = "copy"
            
            self?.navigationController?.pushViewController(copyVC, animated: true)
        }
        
        
        errorPopup.onMoveImageConfirmed = { [weak self] in
            // Navigate or handle logic when "Copy" is tapped
            let copyVC = CopyMoveViewController()
            copyVC.imageId = errorPopup.imageId
            copyVC.imageName = errorPopup.imageName
            copyVC.imageSize = errorPopup.imageSize
            copyVC.typeOfAction = "move"
            
            self?.navigationController?.pushViewController(copyVC, animated: true)
        }
        
        self.present(errorPopup, animated: true)
    }
    
    
    
    
    func deleteImage() {
       // activityIndicator.startAnimating()
        startCustomLoader()
        imageDeleteViewModel.requestModel.image_id = imageCode
        imageDeleteViewModel.deleteImage(request:imageDeleteViewModel.requestModel) { result in
            DispatchQueue.main.async {
               // self.activityIndicator.stopAnimating()
                self.stopCustomLoader()
                switch result {
                case .goAhead:
                    print("Success for Deleting the photo")
                    //table View Reload Data
                    DispatchQueue.main.async {
                        //self.contactsTblView.reloadData()
                        self.dismiss(animated: true )
                        self.imageCount.remove(at: self.imageIndex)
                        
                        
                        //calculation of cell size
                        
                        let sumHeight = (Int(self.dynamicHeight) * (self.imageCount.count)) / 2
                        if let countData = self.catalogueImageListViewModel.responseModel?.data?.count {
                            
                            if countData % 2 == 0{
                                let height:CGFloat = CGFloat(sumHeight)
                                self.collectionViewHeight.constant = height + 100
                                self.scrollViewHeight.constant = self.collectionViewHeight.constant + 370
                            } else {
                                let height:CGFloat = CGFloat(sumHeight)
                                self.collectionViewHeight.constant = height + 120 + 90
                                self.scrollViewHeight.constant = self.collectionViewHeight.constant + 370
                            }
                            
                            
                        } else {
                            
                        }
                        //Ending Of calculation of cell
                        
                        self.catalogueCollView.reloadData()
                        //self.deleteDelegate?.updateUI()
                    }
                case .heyStop:
                    print("Error")
                }
                
                
            }
        }
    }
    
}



