//
//  SharedImageByMeVC.swift
//  Emotipics
//
//  Created by Onqanet on 24/04/25.
//

import UIKit

class SharedImageByMeVC: UIViewController {

    
    
    @IBOutlet weak var roundedView: UIView!{
        didSet{
            roundedView.layer.cornerRadius = 35
            roundedView.clipsToBounds = true
        }
    }
    
    
    
    @IBOutlet weak var collView: UICollectionView!
    
    
    
    @IBOutlet weak var segmentControlShared: UISegmentedControl!
    
    
    var sharedImageByMeViewModel: SharedImageByMeViewModel = SharedImageByMeViewModel()
    
    private var loaderView: ImageLoaderView?
    
    
    var logginUserCode = ""
    
    
    var sharedImageData:[SharedData] = []
    
    
    var imageCache = [String: UIImage]()
    
    var dynamicHeight: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        collView.dataSource = self
        collView.delegate = self
        

        
        collView.register(UINib(nibName: "ImageCatalogueViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageCataCell")
        
        // Do any additional setup after loading the view.
        addingLayoutOfPages()
        sharedByMeList()
    }

    
    func updateContentForSelectedSegment(_ selectedIndex: Int) {
        // This is where you would update your UI based on which segment is selected
        if selectedIndex == 0 {
            //loadShareByMeContent()
            imageCache = [:]

            sharedByMeList()
        } else {
            //loadSharedWithMeContent()
            imageCache = [:]

            sharedWithMeList()
        }
    }
    
    
    
    
    func sharedByMeList() {
        guard let storedCode = UserDefaults.standard.string(forKey: "userCode") else {
            return
        }

        sharedImageByMeViewModel.requestModel.limit = "20"
        sharedImageByMeViewModel.requestModel.offset = "1"
        sharedImageByMeViewModel.requestModel.usercode = storedCode
        sharedImageByMeViewModel.requestModel.sharetype = "byme"

        startCustomLoader()

        sharedImageByMeViewModel.sharedImageByMeViewModel(request: sharedImageByMeViewModel.requestModel) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                //self.stopCustomLoader()

                switch result {
                case .goAhead:
                    print("Shared Catalogue View Model From Shared Catalogue View Controller")
                    guard let value = self.sharedImageByMeViewModel.responseModel?.data else {
                        return
                    }

                    self.sharedImageData = value
                    self.collView.reloadData()
                    self.stopCustomLoader()

                case .heyStop:
                    print("Error")
                    self.stopCustomLoader()
                }
            }
        }
    }

    
    func sharedWithMeList() {
        guard let storedCode = UserDefaults.standard.string(forKey: "userCode") else {
            return
        }

        sharedImageByMeViewModel.requestModel.limit = "20"
        sharedImageByMeViewModel.requestModel.offset = "1"
        sharedImageByMeViewModel.requestModel.usercode = storedCode
        sharedImageByMeViewModel.requestModel.sharetype = "withme"

        startCustomLoader()

        sharedImageByMeViewModel.sharedImageByMeViewModel(request: sharedImageByMeViewModel.requestModel) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
               // self.stopCustomLoader()

                switch result {
                case .goAhead:
                    print("Shared Catalogue View Model From Shared Catalogue View Controller")
                    guard let value = self.sharedImageByMeViewModel.responseModel?.data else {
                        return
                    }

                    self.sharedImageData = value
                    self.collView.reloadData()
                    self.stopCustomLoader()

                case .heyStop:
                    print("Error")
                    self.stopCustomLoader()
                }
            }
        }
    }

    

    func addingLayoutOfPages(){
        if let segmentedControl = segmentControlShared {
            
            let whiteBackground = UIImage(color: .white, size: CGSize(width: 1, height: 32))
            
            let greenBackground = UIImage(named: "SegmentBackground")?.withRenderingMode(.alwaysOriginal)
            let resizableImage = greenBackground?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch)
            segmentedControl.setBackgroundImage(whiteBackground, for: .normal, barMetrics: .default)
            segmentedControl.setBackgroundImage( resizableImage, for: .selected, barMetrics: .default)
            // Set up the selected and unselected styles
            let normalTextAttributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.gray,
                .font: UIFont.systemFont(ofSize: 14)
                
            ]
            
            let selectedTextAttributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor(red: 0, green: 0.8, blue: 0.8, alpha: 1.0), // Teal color
                .font: UIFont.systemFont(ofSize: 14, weight: .medium)
                
            ]
            
            segmentedControl.setTitleTextAttributes(normalTextAttributes, for: .normal)
            segmentedControl.setTitleTextAttributes(selectedTextAttributes, for: .selected)
            
            // Add the underline indicator for the selected segment
            addUnderlineForSelectedSegment(segmentedControl)
        }
    }

    
    func addUnderlineForSelectedSegment(_ segmentedControl: UISegmentedControl) {

        
        // Create underline view
        let underlineHeight: CGFloat = 4.0
        let underlineWidth: CGFloat = segmentedControl.frame.width / CGFloat(segmentedControl.numberOfSegments)
        let underlineXPosition = CGFloat(segmentedControl.selectedSegmentIndex) * underlineWidth
        
        let underlineView = UIView(frame: CGRect(x: underlineXPosition,
                                                 y: segmentedControl.bounds.size.height - underlineHeight,
                                                 width: underlineWidth,
                                                 height: underlineHeight))
        underlineView.backgroundColor = UIColor(red: 0, green: 0.8, blue: 0.8, alpha: 1.0) // Teal color
        underlineView.tag = 999
        let underlineView2 = UIView(frame: CGRect(x: underlineXPosition,
                                                  y: segmentedControl.bounds.size.height - underlineHeight,
                                                  width: segmentedControl.frame.width,
                                                  height: 4))
        
        underlineView2.backgroundColor = #colorLiteral(red: 0.9058823529, green: 0.9333333333, blue: 0.9607843137, alpha: 1)
        segmentedControl.addSubview(underlineView2)
        segmentedControl.addSubview(underlineView)
    }
    
    
    func startCustomLoader(){
        //        let loaderSize: CGFloat = 220
        
        if loaderView != nil { return }
        let loader = ImageLoaderView(frame: view.bounds)
        loader.center = view.center
        loader.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        loader.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        //loader.layer.cornerRadius = 16
        
        view.addSubview(loader)
        loader.startAnimating()
        
        self.loaderView = loader
        
        // Stop and remove after 5 seconds
    }
    
                         
    func stopCustomLoader(){
        print("Trying to stop loader:", loaderView != nil)
        loaderView?.stopAnimating()
        loaderView?.removeFromSuperview()
        
        loaderView = nil
        
        
    }
    
    
    
    @IBAction func changingSegments(_ sender: Any) {
        
        UIView.animate(withDuration: 0.3) {
            // Find the underline view
            if let underlineView = (sender as AnyObject).subviews.first(where: { $0.tag == 999 }) {
                let underlineWidth = (sender as AnyObject).frame.width / CGFloat((sender as AnyObject).numberOfSegments)
                let underlineXPosition = CGFloat((sender as AnyObject).selectedSegmentIndex) * underlineWidth
                underlineView.frame.origin.x = underlineXPosition
            }
        }
        
        // Handle the segment change
        updateContentForSelectedSegment((sender as AnyObject).selectedSegmentIndex)
    }
    
}






extension SharedImageByMeVC:  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return catalogueListingViewModel.responseModel?.data?.count ?? 0
        return sharedImageData.count
    }
    

    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCataCell", for: indexPath) as! ImageCatalogueViewCell
        cell.layer.cornerRadius = 15
        cell.clipsToBounds = true
        
        if sharedImageData.count == 0 || sharedImageData.isEmpty {
            
        } else {
            cell.imgViewColl.image = nil
            cell.startCustomLoader()


            if let imageURL = sharedImageByMeViewModel.fetchImageURL(for: indexPath.row) {
                
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
//                                print("✅ Cached image for URL: \(imageURL)")
//                                   print("🧠 Current cache count: \(self.imageCache.count)")
//                                   print("📸 Cached keys: \(self.imageCache.keys)")
                                
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

    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
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
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10) // Reduce left & right insets
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let layout = collView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.invalidateLayout() // Ensure the layout updates
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //print("Image Path is ", imagePathName)
      
            if
               let imgName = sharedImageData[indexPath.row].img_name {
                let imagePath = imgName
                print("Selected Image Path: \(imagePath)")
            }
       
    }
}
