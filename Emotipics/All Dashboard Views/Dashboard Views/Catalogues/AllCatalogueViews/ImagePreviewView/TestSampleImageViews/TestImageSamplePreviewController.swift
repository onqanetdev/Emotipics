//
//  TestImageSamplePreviewController.swift
//  Emotipics
//
//  Created by Onqanet on 21/05/25.
//

import UIKit
import Photos


class TestImageSamplePreviewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private let imageNames = ["Party", "Picnic", "Birthday", "Wedding"]
    
    private var collectionView: UICollectionView!
    
    var newImageSet:[ImageData] = []
    
    var imageDeleteViewModel: DeleteImageViewModel = DeleteImageViewModel()
    
    private var loaderView: ImageLoaderView?
    
    var imageIndex = 0
    
  

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupCollectionView()
        setupBackButton()
        
       
        
    }
    
    private func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.register(ZoomableImageCell.self, forCellWithReuseIdentifier: ZoomableImageCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.backgroundColor = .black
        collectionView.showsHorizontalScrollIndicator = false
        view.addSubview(collectionView)
    }
    
    private func setupBackButton() {
        let backButton = UIButton(type: .system)
        backButton.frame = CGRect(x: 20, y: 50, width: 40, height: 40)
        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backButton.tintColor = .white
        backButton.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        view.addSubview(backButton)
    }
    
    @objc private func didTapBack() {
        navigationController?.popViewController(animated: true)
    }
    
    
    
    func deleteImage(indexTag: Int) {
       
        startCustomLoader()
        guard let imageCode = newImageSet[indexTag].id else {
            return
        }
        
        imageIndex = indexTag
        
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
                        self.newImageSet.remove(at: self.imageIndex)
                        self.collectionView.reloadData()
                        //self.deleteDelegate?.updateUI()
                    }
                case .heyStop:
                    print("Error")
                }
                
                
            }
        }
    }
    
    
    
    
    // MARK: - Collection View
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // return imageNames.count
       // return images.count
        return newImageSet.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ZoomableImageCell.identifier, for: indexPath) as? ZoomableImageCell else {
            return UICollectionViewCell()
        }
        
//                let imageName = imageNames[indexPath.item]
//                if let image = UIImage(named: imageName) {
//                    cell.configure(with: image)
//                }
        

        cell.imageView.image = nil // Optional: clear image to avoid showing old image in reused cell
        //  cell.startCustomLoader()
        
        cell.activityIndicator.startAnimating()
        
        
        guard let imgPath = newImageSet[indexPath.row].path,
              let imgName = newImageSet[indexPath.row].img_name else {
            return cell
        }
        
        let imagePath = imgPath + imgName
        
        if let urlImage = URL(string: imagePath) {
            URLSession.shared.dataTask(with: urlImage) { data, _, _ in
                guard let data = data, let image = UIImage(data: data) else {
                    DispatchQueue.main.async {
                        cell.activityIndicator.stopAnimating()
                    }
                    return
                }
                
                
                
                
                DispatchQueue.main.async {
                    //self.imageCache[imagePath] = image // Cache the image
                    
                    if let currentCell = collectionView.cellForItem(at: indexPath) as? ZoomableImageCell {
                        currentCell.imageView.image = image
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
        
        
        
        cell.downloadButton.tag = indexPath.item
        cell.downloadButton.addTarget(self, action: #selector(didTapDownload(_:)), for: .touchUpInside)
        
        cell.shareButton.tag = indexPath.item
        cell.shareButton.addTarget(self, action: #selector(didTapShare(_:)), for: .touchUpInside)
        
        cell.deleteButton.tag = indexPath.item
        cell.deleteButton.addTarget(self, action: #selector(didTapDelete(_:)), for: .touchUpInside)
        
        //MARK: Rest of the buttons
        cell.birthdayButton.tag = indexPath.item
        cell.birthdayButton.addTarget(self, action: #selector(didTapBirthday(_:)), for: .touchUpInside)
        
        cell.copyIconButton.tag = indexPath.item
        cell.copyIconButton.addTarget(self, action: #selector(didTapCopy(_:)), for: .touchUpInside)
        
        cell.moveIconButton.tag = indexPath.item
        cell.moveIconButton.addTarget(self, action: #selector(didTapMove(_:)), for: .touchUpInside)
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
    
    
    
    // MARK: - Button Actions
    
    @objc private func didTapDownload(_ sender: UIButton) {
        
//        let imageName = newImageSet[sender.tag]
//        if let imgInitialPath = newImageSet[sender.tag].path,
//           let imgLastPath = newImageSet[sender.tag].img_name {
//            let imageFinalPath = imgInitialPath + imgLastPath
//            print("Final Image Path is->", imageFinalPath)
//        } else {
//            print("Something went wrong in the image path")
//        }
        
        
        if let imgInitialPath = newImageSet[sender.tag].path,
           let imgLastPath = newImageSet[sender.tag].img_name,
           let url = URL(string: imgInitialPath + imgLastPath) {
            
            print("Final Image Path is->", url.absoluteString)

            // Download the image data
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print("Download error: \(error.localizedDescription)")
                    return
                }

                guard let data = data, let image = UIImage(data: data) else {
                    print("Failed to load image data")
                    return
                }

                // Request permission and save to photo library
                PHPhotoLibrary.requestAuthorization { status in
                    if status == .authorized || status == .limited {
                        PHPhotoLibrary.shared().performChanges({
                            PHAssetChangeRequest.creationRequestForAsset(from: image)
                        }) { success, error in
                            DispatchQueue.main.async {
                                if success {
                                    print("✅ Image saved to Photos")
                                } else {
                                    print("❌ Error saving image: \(error?.localizedDescription ?? "Unknown error")")
                                }
                            }
                        }
                    } else {
                        print("🚫 Permission to access photo library denied")
                    }
                }

            }.resume()

        } else {
            print("Something went wrong in the image path")
        }
       
    }
    
    @objc private func didTapShare(_ sender: UIButton) {
               
        let vc = SharingContactListVC(nibName: "SharingContactListVC", bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        vc.catalogueName = "Demo"
        vc.shareImage = true
        guard let imageId = newImageSet[sender.tag].id else {
            return
        }
        vc.imgId = imageId

        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    @objc private func didTapDelete(_ sender: UIButton) {
            
        deleteImage(indexTag: sender.tag)
        
    }
    
    @objc private func didTapBirthday(_ sender: UIButton) {
        let vc = SharingContactListVC(nibName: "SharingContactListVC", bundle: nil)
        vc.modalPresentationStyle = .fullScreen
        vc.catalogueName = "Demo"
        vc.isBirthday = true
       
        guard let imageId = newImageSet[sender.tag].id,
              let imgURLFirstPath = newImageSet[sender.tag].path,
              let imgURLlastPath = newImageSet[sender.tag].img_name else {
            return
        }
        
        print("Desired Image URL--->", imgURLFirstPath + imgURLlastPath)
        vc.imgId = imageId
        vc.imageURL = imgURLFirstPath + imgURLlastPath
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
        
        
    }
    
    
    @objc private func didTapCopy(_ sender: UIButton) {
        let copyVC = CopyMoveViewController()
        guard let selectedImgId = newImageSet[sender.tag].id,
              let selectedImgNm = newImageSet[sender.tag].img_name,
              let selectedImgSize = newImageSet[sender.tag].image_size else {
            return
        }
        let selectedImgTypeOfAction = "copy"
        
        copyVC.imageId = selectedImgId
        copyVC.imageName = selectedImgNm
        copyVC.imageSize = selectedImgSize
        copyVC.typeOfAction = selectedImgTypeOfAction
        
        self.present(copyVC, animated: true)
    }
    
    
    @objc private func didTapMove(_ sender: UIButton) {
        let moveVC = CopyMoveViewController()

        guard let selectedImgId = newImageSet[sender.tag].id,
              let selectedImgNm = newImageSet[sender.tag].img_name,
              let selectedImgSize = newImageSet[sender.tag].image_size else {
            return
        }
        let selectedImgTypeOfAction = "move"
        
        moveVC.imageId = selectedImgId
        moveVC.imageName = selectedImgNm
        moveVC.imageSize = selectedImgSize
        moveVC.typeOfAction = "move"
        
        self.present(moveVC, animated: true)
    }

    
    func startCustomLoader(){
      
        if loaderView != nil { return }
        let loader = ImageLoaderView(frame: view.bounds)
        loader.center = view.center
        loader.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        loader.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        //loader.layer.cornerRadius = 16
        
        view.addSubview(loader)
        loader.startAnimating()
        
        self.loaderView = loader
        
    }
    
    func stopCustomLoader(){
        print("Trying to stop loader:", loaderView != nil)
        loaderView?.stopAnimating()
        loaderView?.removeFromSuperview()
        
        loaderView = nil
    }
    
}





