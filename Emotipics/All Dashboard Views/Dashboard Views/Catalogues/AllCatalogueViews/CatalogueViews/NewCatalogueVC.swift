//
//  NewCatalogueVC.swift
//  Emotipics
//
//  Created by Onqanet on 16/05/25.
//

import UIKit

class NewCatalogueVC: UIViewController {
    
    
    
    
    @IBOutlet weak var catalogueCollView: UICollectionView!
    
    
    @IBOutlet weak var bgCurveView: UIView! {
        didSet{
            bgCurveView.layer.cornerRadius = 30
            bgCurveView.clipsToBounds = true
        }
    }
    

    
    @IBOutlet weak var photoCollView: UICollectionView!
    
    
    
    @IBOutlet weak var myCatalogue: UILabel!
    
    
    var collectionHeight:Int = 150
    
    
    
    
    var dynamicHeight: CGFloat = 0
    
    
    @IBOutlet weak var uploadImgBtn: UIButton!{
        didSet{
            uploadImgBtn.layer.cornerRadius = 15
            uploadImgBtn.clipsToBounds = true
            uploadImgBtn.layer.borderWidth = 1
            uploadImgBtn.layer.borderColor = UIColor.systemTeal.cgColor
        }
    }
    
    
    
    @IBOutlet weak var createCatalogBtn: UIButton!{
        didSet {
            createCatalogBtn.layer.cornerRadius = 15
            createCatalogBtn.clipsToBounds = true
            
            createCatalogBtn.layer.borderWidth = 1
            createCatalogBtn.layer.borderColor = UIColor(red: 2/255, green: 81/255, blue: 167/255, alpha: 1).cgColor
        }
    }
    
    
    
    
    @IBOutlet weak var sortIcon: UIImageView!{
        didSet {
            sortIcon.image = UIImage(named: "SortIcon")?.withRenderingMode(.alwaysTemplate)
            sortIcon.tintColor = UIColor(red: 171/255, green: 210/255, blue: 252/255, alpha: 1)  // Set to the color you want
        }
    }
    
    
    
    
    var catalogueListingViewModel:CatalogueListingViewModel = CatalogueListingViewModel()
    
    var catalogueImageListViewModel: CatalogueImageListViewModel = CatalogueImageListViewModel()
    
    
    private var loaderView: ImageLoaderView?
    
    
    var tempMemory:[DataM] = []
    
    
   
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        catalogueCollView.delegate = self
        catalogueCollView.dataSource = self
        
        catalogueCollView.register(UINib(nibName: "NewCatCollViewCell", bundle: nil), forCellWithReuseIdentifier: "NewCatView")
        
       // showSkeleton()
        
        
        // Table Views for contact Listing
        photoCollView.dataSource = self
        photoCollView.delegate = self
        
        photoCollView.register(UINib(nibName: "ImageCatalogueViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageCataCell")
        
        settingUpAllFonts()
        
        loadAllCatalogueData()
        
    }


    @IBAction func previousView(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
    }
    
    
    private func settingUpAllFonts() {
        uploadImgBtn.titleLabel?.font = UIFont(name: textInputStyle.latoBold.rawValue, size: 15)
        createCatalogBtn.titleLabel?.font = UIFont(name: textInputStyle.latoBold.rawValue, size: 15)
        
        myCatalogue.font = UIFont(name: textInputStyle.latoBold.rawValue, size: 19)
    }
    
    
    

    
    
    func loadAllCatalogueData() {
        catalogueListingViewModel.requestModel.limit = "50"
        catalogueListingViewModel.requestModel.offset = "1"
        catalogueListingViewModel.requestModel.sort_folder = "DESC"
        catalogueListingViewModel.requestModel.type_of_list = "catalog_lists"
        
        startCustomLoader()
        
        catalogueListingViewModel.catalogueListing(request: catalogueListingViewModel.requestModel) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                
                //self.stopCustomLoader()
                switch result {
                case .goAhead:
                    print("Catalogue View Model from New Catalogue VC")
                    self.catalogueCollView.reloadData()
                    
                    if let value = self.catalogueListingViewModel.responseModel?.data {
                        self.tempMemory = value
                        self.catalogueCollView.reloadData()
                    }
                    
                    let sumHeight = (Int(self.dynamicHeight) * (self.catalogueListingViewModel.responseModel?.data?.count ?? 1)) / 2
                    print("Sum height: \(sumHeight)")

                    if let countData = self.catalogueListingViewModel.responseModel?.data?.count {
                        print("Count data 👉🏾 👉🏾 👉🏾 👉🏾 👉🏾 👉🏾", countData)
                    }
                    
                    self.stopCustomLoader()
                    
                case .heyStop:
                    print("Error")
                    self.stopCustomLoader()
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
