//
//  NewSharedCatalogueVC.swift
//  Emotipics
//
//  Created by Onqanet on 20/05/25.
//

import UIKit

class NewSharedCatalogueVC: UIViewController {
    
    
    @IBOutlet weak var shareCatalogueFolderCollView: UICollectionView!
    
    
    @IBOutlet weak var shareCataloguePhotoCollView: UICollectionView!
    
    
    
    @IBOutlet weak var curvedView: UIView!{
        didSet {
            curvedView.layer.cornerRadius = 40
            curvedView.clipsToBounds = true
        }
    }
    
    
    
    @IBOutlet weak var shareCatalogueLbl: UILabel!
    

    
    @IBOutlet weak var shareByMeBtn: UIButton!{
        didSet {
            shareByMeBtn.layer.cornerRadius = 15
            shareByMeBtn.clipsToBounds = true
            shareByMeBtn.layer.borderWidth = 1
            shareByMeBtn.layer.borderColor = UIColor.systemTeal.cgColor
        }
    }
    
    @IBOutlet weak var shareWithMeBtn: UIButton!{
        didSet{
            shareWithMeBtn.layer.cornerRadius = 15
            shareWithMeBtn.clipsToBounds = true
            shareWithMeBtn.layer.borderWidth = 1
            shareWithMeBtn.layer.borderColor = UIColor(red: 134/255, green: 133/255, blue: 147/255, alpha: 1).cgColor
        }
    }
    
    
    
    
    
    
    
    
    var sharedCatalogueViewModel:CatalogueListingViewModel = CatalogueListingViewModel()
    
    
    var sharedData: [DataM] = []
    
    private var loaderView: ImageLoaderView?
    
    var selectedIndexPath: IndexPath?
    
    
    var collectionHeight:Int = 150
    
    var dynamicHeight: CGFloat = 0
    
    
    var catalogueImageListViewModel: CatalogueImageListViewModel = CatalogueImageListViewModel()
    
    var imageCache = [String: UIImage]()
    var imageCount:[ImageData] = []
    
    var catalogCode = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        shareCatalogueFolderCollView.delegate = self
        shareCatalogueFolderCollView.dataSource = self
        
        shareCatalogueFolderCollView.register(UINib(nibName: "NewCatCollViewCell", bundle: nil), forCellWithReuseIdentifier: "NewCatView")
        
    
        shareCataloguePhotoCollView.dataSource = self
        shareCataloguePhotoCollView.delegate = self
        
        shareCataloguePhotoCollView.register(UINib(nibName: "ImageCatalogueViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageCataCell")
        
        shareByMe()
        
        settingUpAllFonts()
    }

    
    
    private func settingUpAllFonts() {
        shareByMeBtn.titleLabel?.font = UIFont(name: textInputStyle.latoBold.rawValue, size: 15)
        shareWithMeBtn.titleLabel?.font = UIFont(name: textInputStyle.latoBold.rawValue, size: 15)
        
        shareCatalogueLbl.font = UIFont(name: textInputStyle.latoBold.rawValue, size: 19)
    }
    
    

    func shareByMe() {
        sharedCatalogueViewModel.requestModel.limit = "10"
        sharedCatalogueViewModel.requestModel.offset = "1"
        sharedCatalogueViewModel.requestModel.sort_folder = "DESC"
        sharedCatalogueViewModel.requestModel.type_of_list = "catalog_share_byme"
        
        startCustomLoader()
        
        sharedCatalogueViewModel.catalogueListing(request: sharedCatalogueViewModel.requestModel) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.stopCustomLoader()
                
                switch result {
                case .goAhead:
                    guard let sharedData = self.sharedCatalogueViewModel.responseModel?.data else {
                        print("No shared data found")
                        return
                    }
                    
                    
                    if let value = self.sharedCatalogueViewModel.responseModel?.data {
                        self.sharedData = value
                        
                        self.catalogCode = self.sharedData[0].catalog_code ?? ""
                        
                        
                        self.selectedIndexPath = IndexPath(row: 0, section: 0)
                        
                        self.loadAllImageCatalogue(catalogueCode: self.catalogCode)
                        self.selectedIndexPath?.row = 0
                        
                        self.shareCatalogueFolderCollView.reloadData()
                        self.shareCataloguePhotoCollView.reloadData()
                    }
                    
                    
                    
                    self.sharedData = sharedData
                    self.shareCatalogueFolderCollView.reloadData()
                    self.shareCataloguePhotoCollView.reloadData()
                    
                case .heyStop:
                    print("Error fetching shared by me")
                }
            }
        }
    }

    
    func shareWithMe() {
        sharedCatalogueViewModel.requestModel.limit = "10"
        sharedCatalogueViewModel.requestModel.offset = "1"
        sharedCatalogueViewModel.requestModel.sort_folder = "DESC"
        sharedCatalogueViewModel.requestModel.type_of_list = "catalog_share_withme"
        
        startCustomLoader()
        
        sharedCatalogueViewModel.catalogueListing(request: sharedCatalogueViewModel.requestModel) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.stopCustomLoader()
                
                switch result {
                case .goAhead:
                    guard let sharedData = self.sharedCatalogueViewModel.responseModel?.data else {
                        print("No shared data found")
                        return
                    }
                    
                    
                    
                    
                    
                    if let value = self.sharedCatalogueViewModel.responseModel?.data {
                        self.sharedData = value
                        
                        self.catalogCode = self.sharedData[0].catalog_code ?? ""
                        
                        
                        self.selectedIndexPath = IndexPath(row: 0, section: 0)
                        
                        self.loadAllImageCatalogue(catalogueCode: self.catalogCode)
                        self.selectedIndexPath?.row = 0
                        
                        self.shareCatalogueFolderCollView.reloadData()
                        self.shareCataloguePhotoCollView.reloadData()
                    }
                    
                    
                    
                    
                    self.sharedData = sharedData
                    self.shareCatalogueFolderCollView.reloadData()
                    self.shareCataloguePhotoCollView.reloadData()
                    
                case .heyStop:
                    print("Error fetching shared with me")
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
                        self.shareCataloguePhotoCollView.reloadData()
                        self.stopCustomLoader()
                        return
                    }
                    
                    self.imageCount = value
                    
                    if self.imageCount.isEmpty || self.imageCount.count == 0 {
                        print("The Image count is 0")
                        self.shareCataloguePhotoCollView.isHidden = true
                        self.imageCache.removeAll() // ✅ Clear cache
                        self.shareCataloguePhotoCollView.isHidden = true
                    } else {
                        print("Image count is there", self.imageCount.count)
                        // You can use `sumHeight` for layout purposes if needed
                    }
                    
                    
    
                    
                    self.shareCataloguePhotoCollView.reloadData()
                    self.stopCustomLoader()
                    
                case .heyStop:
                    print("Error")
                    self.stopCustomLoader()
                }
            }
        }
    }
    
    
    
    
    
    @IBAction func backToPrevious(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func shareByMe(_ sender: Any) {
        shareByMe()
        changingColour(shareWithMe: false)
    }
    
    
    
    @IBAction func shareWithMe(_ sender: Any) {
        shareWithMe()
        changingColour(shareWithMe: true)
    }
    
    
    
    
    func changingColour(shareWithMe: Bool) {
        if shareWithMe == true {
            shareByMeBtn.layer.borderColor = UIColor(red: 134/255, green: 133/255, blue: 147/255, alpha: 1).cgColor
            shareByMeBtn.backgroundColor = UIColor(red: 232/255, green: 238/255, blue: 243/255, alpha: 1)
            shareByMeBtn.titleLabel?.textColor = UIColor(red: 134/255, green: 133/255, blue: 147/255, alpha: 1)
            
            shareWithMeBtn.layer.borderColor = UIColor.systemTeal.cgColor
            shareWithMeBtn.backgroundColor = UIColor(red: 217/255, green: 240/255, blue: 240/255, alpha: 1)
            shareWithMeBtn.setTitleColor(UIColor(red: 0/255, green: 153/255, blue: 153/255, alpha: 1), for: .normal)

          
        }
        else
        {
            shareByMeBtn.layer.borderColor = UIColor.systemTeal.cgColor
            shareByMeBtn.backgroundColor = UIColor(red: 217/255, green: 240/255, blue: 240/255, alpha: 1)
            shareByMeBtn.titleLabel?.textColor = UIColor(red: 0/255, green: 153/255, blue: 153/255, alpha: 1)
            
            
            shareWithMeBtn.layer.borderColor = UIColor(red: 134/255, green: 133/255, blue: 147/255, alpha: 1).cgColor
            shareWithMeBtn.backgroundColor = UIColor(red: 232/255, green: 238/255, blue: 243/255, alpha: 1)
            shareWithMeBtn.titleLabel?.textColor = UIColor(red: 134/255, green: 133/255, blue: 147/255, alpha: 1)
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
