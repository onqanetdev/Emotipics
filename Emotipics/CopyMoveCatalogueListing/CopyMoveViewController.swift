//
//  CopyMoveViewController.swift
//  Emotipics
//
//  Created by Onqanet on 21/04/25.
//

import UIKit

class CopyMoveViewController: UIViewController {

    
    @IBOutlet weak var roundedView: UIView!{
        didSet{
            roundedView.layer.cornerRadius = 20
            roundedView.clipsToBounds = true
        }
    }
    
    
    @IBOutlet weak var allCatalogueCollView: UICollectionView!
    
    var totalCatalogueCount:[DataM] = []
    
    
    var catalogueListingViewModel:CatalogueListingViewModel = CatalogueListingViewModel()
    
    private var loaderView: ImageLoaderView?
    
    
    var dynamicHeight: CGFloat = 0
    
    
    @IBOutlet weak var scrollViewHeight: NSLayoutConstraint!
    
    
    
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    
    
    
    var imageId = 0
    var imageName = ""
    var imageSize = ""
    var typeOfAction = ""
    
    var imageCopyOrMoveViewModel: ImageCopyOrMoveViewModel = ImageCopyOrMoveViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        loadData()
        
        allCatalogueCollView.delegate = self
        allCatalogueCollView.dataSource = self
        
        // Do any additional setup after loading the view.
        allCatalogueCollView.register(UINib(nibName: "EntryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        
        
       
    }


    

    
    func loadData() {
        catalogueListingViewModel.requestModel.limit = "10"
        catalogueListingViewModel.requestModel.offset = "1"
        catalogueListingViewModel.requestModel.sort_folder = "DESC"
        catalogueListingViewModel.requestModel.type_of_list = "catalog_lists"
        
        // activityIndicator.startAnimating()
        startCustomLoader()
        
        catalogueListingViewModel.catalogueListing(request: catalogueListingViewModel.requestModel) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                // self.activityIndicator.stopAnimating()
                self.stopCustomLoader()
                
                switch result {
                case .goAhead:
                    print("Catalogue View Model from AllCataloguesViewController")
                    self.allCatalogueCollView.reloadData()
                    
                    guard let value = self.catalogueListingViewModel.responseModel?.data else {
                        return
                    }
                    
                    self.totalCatalogueCount = value
                    self.allCatalogueCollView.reloadData()
                    
                    // Calculating the height of catalogue cell
                    let sumHeight = (Int(self.dynamicHeight) * (self.catalogueListingViewModel.responseModel?.data?.count ?? 1)) / 2
                    
                    if let countData = self.catalogueListingViewModel.responseModel?.data?.count {
                        if countData % 2 == 0 {
                            let height: CGFloat = CGFloat(sumHeight)
                            self.collectionViewHeight.constant = height
                            self.scrollViewHeight.constant = self.collectionViewHeight.constant + 370
                            
                            // Recalculating constant
                            self.collectionViewHeight.constant = self.scrollViewHeight.constant
                        } else {
                            let height: CGFloat = CGFloat(sumHeight)
                            self.collectionViewHeight.constant = height + 120
                            self.scrollViewHeight.constant = self.collectionViewHeight.constant + 370
                            
                            // Recalculating constant
                            self.collectionViewHeight.constant = self.scrollViewHeight.constant
                        }
                    }
                    
                    self.allCatalogueCollView.reloadData()
                    
                case .heyStop:
                    print("Error")
                }
            }
        } // view model Completion handler ending
    }

    

    func imageCopy(actionType:String, imgId: Int, catalogCode: String, imgSize: String, imageName: String ){
        imageCopyOrMoveViewModel.requestModel.actiontype = actionType
        imageCopyOrMoveViewModel.requestModel.imgid = imgId
        imageCopyOrMoveViewModel.requestModel.catalog_code = catalogCode
        imageCopyOrMoveViewModel.requestModel.img_size = imgSize
        imageCopyOrMoveViewModel.requestModel.img_name = imageName
        
        startCustomLoader()
        
        
        imageCopyOrMoveViewModel.copyOrMoveImg(request: imageCopyOrMoveViewModel.requestModel) { result in
            DispatchQueue.main.async { [self] in
               // self.activityIndicator.stopAnimating()
                
                self.stopCustomLoader()
                switch result {
                case .goAhead:
                    //print("View Model Copy Image or Move Image")
                    
                    // UIWindow reset logic
                    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                          let window = windowScene.windows.first else {
                        return
                    }

                    let dashboardVC = DashboardViewController()
                    let navController = UINavigationController(rootViewController: dashboardVC)
                    window.rootViewController = navController
                    window.makeKeyAndVisible()
                    
                case .heyStop:
                    print("Error")
                }
                
                
            }
            
            
        }
        
        
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

}



extension CopyMoveViewController:UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return totalCatalogueCount.count
        //return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! EntryCollectionViewCell
        cell.layer.cornerRadius = 15
        cell.clipsToBounds = true
        
        
        cell.projectFilesLbl.text = totalCatalogueCount[indexPath.row].catalog_name
        cell.noOfFiles.text = "\(totalCatalogueCount[indexPath.row].totalcatalogfile ?? 0)"
        cell.fiveGbLbl.text = totalCatalogueCount[indexPath.row].catalogimagesize
        
        cell.moreFeaturesBtn.tag = indexPath.row
        

        
        
        return cell
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfItemsPerRow: CGFloat = 2
        let spacingBetweenCells: CGFloat = 10
        let sectionInsets: CGFloat = 10 // Reduced from 20 to avoid width issues
        
        let totalSpacing = (numberOfItemsPerRow - 1) * spacingBetweenCells + (sectionInsets * 2)
        let availableWidth = collectionView.bounds.width - totalSpacing
        
        let cellWidth = availableWidth / numberOfItemsPerRow
          //  dynamicHeight = 120
            return CGSize(width: max(0, cellWidth), height: 120)

        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10) // Reduce left & right insets
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let layout = allCatalogueCollView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.invalidateLayout() // Ensure the layout updates
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Catalog Code", totalCatalogueCount[indexPath.row].catalog_code)
        print("Action Type", typeOfAction)
        print("Image Name", imageName)
        print("Image Size", imageSize)
        print("Image Id", imageId)
        
    
        if let imgCatCode = totalCatalogueCount[indexPath.row].catalog_code {
            imageCopy(actionType: typeOfAction, imgId: imageId , catalogCode: imgCatCode , imgSize: imageSize, imageName: imageName)
        } else {
            
        }
        
    }
}









