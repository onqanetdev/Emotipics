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
            return tempMemory.count
        } else {
            return imageCount.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == catalogueCollView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewCatView", for: indexPath) as! NewCatCollViewCell
            cell.layer.cornerRadius = 20
            
            
            cell.projectFilesLbl.text = tempMemory[indexPath.row].catalog_name
            cell.noOfFiles.text = "\(tempMemory[indexPath.row].totalcatalogfile ?? 0)"
            cell.availableSpaceDetails.text = tempMemory[indexPath.row].catalogimagesize
            cell.borderView.isHidden = indexPath == selectedIndexPath ? false : true
            
            if  indexPath == selectedIndexPath {
                if let catalogueId = tempMemory[indexPath.row].catalog_code {
                    
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
            cell.moreFeaturesBtn.addTarget(self, action: #selector(deleteCatalogueBtnAction(_:)), for: .touchUpInside)
            
            //            tempMemoryImages.removeAll()
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
                            
                            
                            
                            //                            DispatchQueue.global(qos: .background).async { [weak self] in
                            //                                guard let self = self else { return }
                            //
                            //                                // Expensive check in background
                            //                                let isAlreadyAdded = self.tempMemoryImages.contains { $0.pngData() == image.pngData() }
                            //
                            //                                if !isAlreadyAdded {
                            //                                    self.tempMemoryImages.append(image)
                            //                                }
                            //
                            //                                // UI updates on main thread
                            //                                DispatchQueue.main.async {
                            //                                    self.imageCache[imagePath] = image
                            //
                            //                                    if let currentCell = collectionView.cellForItem(at: indexPath) as? ImageCatalogueViewCell {
                            //                                        currentCell.imgViewColl.image = image
                            //                                        currentCell.activityIndicator.stopAnimating()
                            //                                    }
                            //                                }
                            //                            }
                            
                            
                            
                            
                        }.resume()
                    }
                } //else Ending Here
                
            }
            
            return cell
        } //else ending
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
            return CGSize(width: max(0, cellWidth), height: cellWidth * 0.7)
            
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == catalogueCollView {
            return UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 65)
        } else {
            return UIEdgeInsets(top: 10, left: 15, bottom: 15, right: 15)
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == catalogueCollView {
            
            selectedIndexPath = indexPath
            guard let catCode = tempMemory[indexPath.row].catalog_code else { return }
            loadAllImageCatalogue(catalogueCode: catCode)
            collectionView.reloadData()
            
        } else {
//            if let imgPath = imageCount[indexPath.row].path,
//               let imgName = imageCount[indexPath.row].img_name {
//                let imagePath = imgPath + imgName
//                print("Image Path:", imagePath)
//            } else {
//                
//            }
//            
//            
//            print("Total numbers of Image--> ", tempMemoryImages)
//            
//            let previewVC = TestImageSamplePreviewController()
//            
//           // previewVC.images = tempMemoryImages
//            previewVC.newImageSet = imageCount
//            
//            self.navigationController?.pushViewController(previewVC, animated: true)
            
            
            let allImages = imageCount
                
                // The index the user tapped
                let tappedIndex = indexPath.row
                
                // 1. Pull out the tapped image
                let firstImage = allImages[tappedIndex]
                
                // 2. Build a new array beginning with the tapped image, then all the others in order
                let remaining = allImages.enumerated()
                                          .filter { $0.offset != tappedIndex }   // drop the tapped one
                                          .map { $0.element }                     // extract the image objects
                let reordered = [firstImage] + remaining
                
                // 3. Pass the reordered array to your preview VC
                let previewVC = TestImageSamplePreviewController()
                previewVC.newImageSet = reordered
                //previewVC.indexNoFetched = 0    // since we moved the tapped image to index zero
                navigationController?.pushViewController(previewVC, animated: true)
            
        }
    }
}






