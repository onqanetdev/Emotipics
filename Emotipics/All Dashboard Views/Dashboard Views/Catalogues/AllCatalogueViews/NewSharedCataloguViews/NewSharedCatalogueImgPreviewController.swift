//
//  SharedCatalogueImgPreviewController.swift
//  Emotipics
//
//  Created by Onqanet on 05/06/25.
//

import UIKit
import Photos

class NewSharedCatalogueImgPreviewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    private var collectionView: UICollectionView!
    
  
    
    
    
    private var loaderView: ImageLoaderView?
    
    var imageIndex = 0
    
   // MARK: For Group Image Details
   // var isGrpDetailImg:Bool = false

    var sharedImageSet:[ImageData] = []
    
    
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
        collectionView.register(NewSharedCatalogueImgPreviewCell.self, forCellWithReuseIdentifier: NewSharedCatalogueImgPreviewCell.identifier)
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
    
    

    
    
    
    
    // MARK: - Collection View
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    
           return sharedImageSet.count
       
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewSharedCatalogueImgPreviewCell.identifier, for: indexPath) as? NewSharedCatalogueImgPreviewCell else {
            return UICollectionViewCell()
        }
    
       
        
        cell.imageView.image = nil // Optional: clear image to avoid showing old image in reused cell
        //  cell.startCustomLoader()
    
            cell.activityIndicator.startAnimating()
            
        guard let imgName = sharedImageSet[indexPath.row].img_name,
              let imgPath = sharedImageSet[indexPath.row].path
        
        else {
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
                        
                        if let currentCell = collectionView.cellForItem(at: indexPath) as? NewSharedCatalogueImgPreviewCell {
                            currentCell.imageView.image = image
                            // currentCell.stopCustomLoader()
                            currentCell.activityIndicator.stopAnimating()
                        }
                    }
                }.resume()
            }
        
        cell.downloadButton.tag = indexPath.item
        cell.downloadButton.addTarget(self, action: #selector(didTapDownload(_:)), for: .touchUpInside)
        
       
        
        cell.shareButton.tag = indexPath.item
        cell.shareButton.addTarget(self, action: #selector(didTapShare(_:)), for: .touchUpInside)
        
        //MARK: Rest of the buttons
        
        
        
      //  }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
    
    
    
    // MARK: - Button Actions
    
    @objc private func didTapDownload(_ sender: UIButton) {
    
        
        if
           let imgLastPath = sharedImageSet[sender.tag].img_name,
           let url = URL(string: imgLastPath) {
            
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
        guard let imageId = sharedImageSet[sender.tag].id else {
            return
        }
        vc.imgId = imageId

        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
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
