//
//  NewSharedCatalogueVC+CollectionViews.swift
//  Emotipics
//
//  Created by Onqanet on 20/05/25.
//

import Foundation
import UIKit






extension NewSharedCatalogueVC: UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == shareCatalogueFolderCollView {
            //return tempMemory.count
            return sharedData.count
        } else {
           // return imageCount.count
            return imageCount.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == shareCatalogueFolderCollView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewCatView", for: indexPath) as! NewCatCollViewCell
            cell.layer.cornerRadius = 20
            
            
            cell.projectFilesLbl.text = sharedData[indexPath.row].catalog_name
            cell.noOfFiles.text = "\(sharedData[indexPath.row].totalcatalogfile ?? 0)" + " Files"
            cell.availableSpaceDetails.text = sharedData[indexPath.row].catalogimagesize
            cell.borderView.isHidden = indexPath == selectedIndexPath ? false : true

            cell.shareByMeLbl.isHidden = false
            cell.shareByMeLbl.text = sharedData[indexPath.row].owner_detials?.name
            
            
            if  indexPath == selectedIndexPath {
                if let catalogueId = sharedData[indexPath.row].catalog_code {
                    
                    print("My Catalogue id is catalogueId", catalogueId)
                    UserDefaults.standard.set(catalogueId, forKey: "catalogueId")
                }
                
                cell.borderView.isHidden = false
                cell.mainView.backgroundColor = .systemBlue
                cell.moreFeaturesBtn.tintColor = .white
                cell.noOfFiles.textColor = .white
                cell.availableSpaceDetails.textColor = .white
                cell.projectFilesLbl.textColor = .white
                cell.showFolder.image = UIImage(named: "ShowFolder")?.withRenderingMode(.alwaysTemplate)
                cell.showFolder.tintColor = .white
            }
            else
            {
                cell.borderView.isHidden = true
                cell.mainView.backgroundColor = .white
                cell.moreFeaturesBtn.tintColor = .systemGray
                cell.noOfFiles.textColor = UIColor(red: 0/255, green: 153/255, blue: 153/255, alpha: 1)
                cell.availableSpaceDetails.textColor = .black
                cell.projectFilesLbl.textColor = .black
                cell.showFolder.image = UIImage(named: "ShowFolder")
                
            }
           
            
            cell.moreFeaturesBtn.tag = indexPath.row
//            cell.moreFeaturesBtn.addTarget(self, action: #selector(deleteCatalogueBtnAction(_:)), for: .touchUpInside)
            
            return cell
        }
        else
        {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCataCell", for: indexPath) as! ImageCatalogueViewCell
            cell.layer.cornerRadius = 10
            cell.clipsToBounds = true
            
            if let imgPath = imageCount[indexPath.row].path,
               let imgName = imageCount[indexPath.row].img_name {
                let imagePath = imgPath + imgName
                print("Image Path:", imagePath)



                if let cachedImage = imageCache[imagePath] {
                        cell.imgViewColl.image = cachedImage
                       // cell.stopCustomLoader()
                } else {
                    cell.imgViewColl.image = nil // Optional: clear image to avoid showing old image in reused cell
                  //  cell.startCustomLoader()
                    
                    cell.activityIndicator.startAnimating()
                    
                    if let urlImage = URL(string: imagePath) {
                        URLSession.shared.dataTask(with: urlImage) { data, _, _ in
                            guard let data = data, let image = UIImage(data: data) else {
                                DispatchQueue.main.async {
                                                    cell.activityIndicator.stopAnimating()
                                                }
                                return }
                            
                            DispatchQueue.main.async {
                                self.imageCache[imagePath] = image // Cache the image
                                if let currentCell = collectionView.cellForItem(at: indexPath) as? ImageCatalogueViewCell {
                                    currentCell.imgViewColl.image = image
                                   // currentCell.stopCustomLoader()
                                    currentCell.activityIndicator.stopAnimating()
                                }
                            }
                        }.resume()
                    }
                }
                
            }
            
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == shareCatalogueFolderCollView {
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
            return CGSize(width: max(0, cellWidth), height: cellWidth * 0.7)
            
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == shareCatalogueFolderCollView {
            return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 65)
        } else {
            return UIEdgeInsets(top: 10, left: 15, bottom: 15, right: 15)
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == shareCatalogueFolderCollView {
            selectedIndexPath = indexPath
            guard let catCode = sharedData[indexPath.row].catalog_code else { return }
            
             
            if let savedCatalogueId = UserDefaults.standard.string(forKey: "catalogueId") {
                print("Saved catalogue ID: \(savedCatalogueId)")
                print("Same Id required: ", catCode)
            }
            catalogCode = catCode
            currentImageSharedPage = 1
            isPaginatingSharedImage = false
            loadAllImageCatalogue(catalogueCode: catCode)
            collectionView.reloadData()
        } else {
            
//            guard let catCode = sharedData[indexPath.row].catalog_code else { return }
//            loadAllImageCatalogue(catalogueCode: catCode)
            
            
            
            if
                let imgName = imageCount[indexPath.row].img_name {
                let imagePath = imgName
                print("Selected Image Path: \(imagePath)")
            }
            
            let allImgCollection = imageCount
            // The index the user tapped
            let tappedIndex = indexPath.row
            
            // 1. Pull out the tapped image
            let firstImage = allImgCollection[tappedIndex]
            
            let remaining = allImgCollection.enumerated()
                .filter { $0.offset != tappedIndex }   // drop the tapped one
                .map { $0.element }                     // extract the image objects
            let reordered = [firstImage] + remaining
            
            let previewVC = NewSharedCatalogueImgPreviewController()
            previewVC.sharedImageSet = reordered
            
            navigationController?.pushViewController(previewVC, animated: true)
            print("From SharedImageCollView")
            
            
        }
    }
}




