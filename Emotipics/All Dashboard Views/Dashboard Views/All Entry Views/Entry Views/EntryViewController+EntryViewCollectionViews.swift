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
        if collectionView == fileColView {
           return tempMemory.count
           // return isSkeletonVisible ? 10 : tempMemory.count
        } else if collectionView == sharedImageCollView {
           return sharedImageData.count
        }
        else {
            return 4
        }
        //return tempMemory.count
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == fileColView {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! EntryCollectionViewCell
            cell.layer.cornerRadius = 25
            
            if tempMemory.count == 0 || tempMemory.isEmpty { 
                cell.projectFilesLbl.text =  "Example"
                cell.noOfFiles.text = "0 Files"
                cell.fiveGbLbl.text = "12.gb"
            } else {
                cell.projectFilesLbl.text = tempMemory[indexPath.row].catalog_name ?? "Example"
                cell.noOfFiles.text = "\(tempMemory[indexPath.row].totalcatalogfile ?? 0)" + " Files"
                cell.fiveGbLbl.text = tempMemory[indexPath.row].catalogimagesize
            }
            cell.moreFeaturesBtn.tag = indexPath.row
            cell.moreFeaturesBtn.addTarget(self, action: #selector(deleteCatalogueBtnAction(_:)), for: .touchUpInside)
            return cell
            
        } else if collectionView == sharedCatalogueCollView {
            
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! EntryCollectionViewCell
            
            cell.layer.cornerRadius = 25
            cell.clipsToBounds = true
            
            if sharedCataTempMemory.count == 0 || sharedCataTempMemory.isEmpty {
                
                cell.projectFilesLbl.text = "Loading.."
                
            } else {
                cell.projectFilesLbl.text = sharedCataTempMemory[indexPath.row].catalog_name
                
                //cell.noOfFiles.text = "\(sharedCataTempMemory[indexPath.row].totalcatalogfile)"
                if let totalFiles = sharedCataTempMemory[indexPath.row].totalcatalogfile {
                    cell.noOfFiles.text = "\(totalFiles)" + " Files"
                } else {
                    cell.noOfFiles.text = "0" + " Files"
                }
                cell.fiveGbLbl.text = (sharedCataTempMemory[indexPath.row].catalogimagesize ?? "0") + " MB"
            }
            
            
            return cell
    
        } else  {
            
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCataCell", for: indexPath) as! ImageCatalogueViewCell
            cell.layer.cornerRadius = 15
            cell.clipsToBounds = true
            
            if sharedImageData.count == 0 || sharedImageData.isEmpty {
                
            } else {
                cell.imgViewColl.image = nil
                cell.startCustomLoader()

   
                if let imageURL = fetchImageURL(for: indexPath.row) {
                    
                    // Check the cache first
                    if let cachedImage = imageCache[imageURL] {
                        cell.imgViewColl.image = cachedImage
                        cell.stopCustomLoader()
                    } else {
                        cell.imgViewColl.image = nil
                        cell.startCustomLoader()

                        DispatchQueue.global().async {
                            if let url = URL(string: imageURL),
                               let data = try? Data(contentsOf: url),
                               let image = UIImage(data: data) {

                                DispatchQueue.main.async {
                                    self.imageCache[imageURL] = image
                                    print("✅ Cached image for URL: \(imageURL)")
                                       print("🧠 Current cache count: \(self.imageCache.count)")
                                       print("📸 Cached keys: \(self.imageCache.keys)")
                                    
                                    cell.imgViewColl.image = image
                                    cell.stopCustomLoader()
                                }
                            } else {
                                DispatchQueue.main.async {
                                    cell.stopCustomLoader()
                                }
                            }
                        }
                    }
                }

                
                
            }
            
            
            return cell
        }
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == fileColView {
            return CGSize(width: 200, height: collectionHeight)
        } else if collectionView == sharedCatalogueCollView {
            return CGSize(width: 180, height: 110)
        } else {
            //May be change According the Image Size
           // return CGSize(width: 180, height: 110)
            
            let numberOfItemsPerRow: CGFloat = 2
            let spacingBetweenCells: CGFloat = 10
            let sectionInsets: CGFloat = 10 // Reduced from 20 to avoid width issues
            
            let totalSpacing = (numberOfItemsPerRow - 1) * spacingBetweenCells + (sectionInsets * 2)
            let availableWidth = collectionView.bounds.width - totalSpacing
            
            let cellWidth = availableWidth / numberOfItemsPerRow
            
                //print("Image Cell is true")
                dynamicHeight = cellWidth * 1.0
                return CGSize(width: max(0, cellWidth), height: cellWidth * 1.0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == fileColView {
            return UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 65) // Leading space for the first cell
        } else if collectionView == sharedCatalogueCollView {
            let totalCellWidth = 180 * 2 // Two cells per row, each 180 wide
            let totalSpacingWidth = 10 * 1 // One space between two cells
            let horizontalInset = (collectionView.frame.width - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
            return UIEdgeInsets(top: 10, left: horizontalInset, bottom: 10, right: horizontalInset)
        }
        //This is for image section
        else {
            return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == fileColView {
            
//            let imageViewController = AllCataloguesViewController()
//            imageViewController.isImageCell = true
            
            
            let catalogueId = tempMemory[indexPath.row].catalog_code
            let userCode = tempMemory[indexPath.row].owner_detials?.code

            let tappedCatalogueName = tempMemory[indexPath.row].catalog_name
            
            
            
            if let catalogueId = catalogueId {
                UserDefaults.standard.set(catalogueId, forKey: "catalogueId")
            }
            
            if let userCode = userCode {
                UserDefaults.standard.set(userCode, forKey: "userCode")
            }
            
            //Saving the user  selected cell index
            UserDefaults.standard.set(indexPath.row, forKey: "selectedIndexRowCatalogue")
            
            navigationController?.pushViewController(NewCatalogueVC(), animated: true)
            
//            navigationController?.pushViewController(imageViewController, animated: true)
        }
        
        else if collectionView ==  sharedCatalogueCollView {
            print("From SharedCatalogueCollView")
            
            
            
        }
        else if collectionView == sharedImageCollView {
            print("From SharedImageCollView")
        }
    }
    
    
    
    func fetchImageURL(for index: Int) -> String? {
        guard index < sharedImageData.count,
              let path = sharedImageByMeViewModel.responseModel?.path,
              let name = sharedImageData[index].img_name else {
            return nil
        }
        return path + name
    }
}
