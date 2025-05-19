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
    
    var imageCount:[ImageData] = []
    
    var selectedIndexPath: IndexPath?
    
    var imageCache = [String: UIImage]()
    
    var catalogCode = ""
    
    
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
                        
                        self.catalogCode = self.tempMemory[0].catalog_code ?? ""
                        
                        
                        self.selectedIndexPath = IndexPath(row: 0, section: 0)
                        
                        self.loadAllImageCatalogue(catalogueCode: self.catalogCode)
                        self.selectedIndexPath?.row = 0
                        
                        self.catalogueCollView.reloadData()
                        self.photoCollView.reloadData()
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
    
    
    
    func loadAllImageCatalogue(catalogueCode: String) {
        
        catalogueImageListViewModel.requestModel.catalog_code = catalogueCode
        catalogueImageListViewModel.requestModel.limit = "50"
        catalogueImageListViewModel.requestModel.offset = "1"
        
        startCustomLoader()
        
        catalogueImageListViewModel.catalogueImageListViewModel(request: catalogueImageListViewModel.requestModel) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                
                switch result {
                case .goAhead:
                    guard let value = self.catalogueImageListViewModel.responseModel?.data else {
                        // self.photoCollView.isHidden = true
                        self.imageCache.removeAll() // ✅ Clear cache
                        self.imageCount.removeAll()
                        self.photoCollView.reloadData()
                        self.stopCustomLoader()
                        return
                    }
                    
                    self.imageCount = value
                    
                    if self.imageCount.isEmpty || self.imageCount.count == 0 {
                        print("The Image count is 0")
                        self.photoCollView.isHidden = true
                        self.imageCache.removeAll() // ✅ Clear cache
                        self.photoCollView.isHidden = true
                    } else {
                        print("Image count is there", self.imageCount.count)
                        
                        let sumHeight = (Int(self.dynamicHeight) * self.imageCount.count) / 2
                        // You can use `sumHeight` for layout purposes if needed
                    }
                    
                    self.photoCollView.reloadData()
                    self.stopCustomLoader()
                    
                case .heyStop:
                    print("Error")
                    self.stopCustomLoader()
                }
            }
        }
    }
    
    
    
    @IBAction func uploadImgBtnAction(_ sender: Any) {
        
        
    }
    
    
    
    
    @IBAction func createCatalogAction(_ sender: Any) {
        
        
        
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





