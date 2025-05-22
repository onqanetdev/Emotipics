//
//  TestImageSamplePreviewController.swift
//  Emotipics
//
//  Created by Onqanet on 21/05/25.
//

import UIKit

class TestImageSamplePreviewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    private let imageNames = ["Party", "Picnic", "Birthday", "Wedding"]
    
    private var collectionView: UICollectionView!
    
    //var images: [UIImage] = []
    
    // Optional: Closure to receive the images
  //  var onReceiveImages: (([UIImage]) -> Void)?
    
    
    var newImageSet:[ImageData] = []
    
    
    
    //var indexNoFetched = 0
    
    
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
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
    
    
    
    // MARK: - Button Actions
    
    @objc private func didTapDownload(_ sender: UIButton) {
        let imageName = imageNames[sender.tag]
        print("Download tapped for \(imageName)")
        // Add actual download logic here
    }
    
    @objc private func didTapShare(_ sender: UIButton) {
        let imageName = imageNames[sender.tag]
        guard let image = UIImage(named: imageName) else { return }
        let activityVC = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        present(activityVC, animated: true)
    }
    
    @objc private func didTapDelete(_ sender: UIButton) {
        let imageName = imageNames[sender.tag]
        print("Delete tapped for \(imageName)")
        // Add delete logic here (or notify delegate, etc.)
    }
    
}
