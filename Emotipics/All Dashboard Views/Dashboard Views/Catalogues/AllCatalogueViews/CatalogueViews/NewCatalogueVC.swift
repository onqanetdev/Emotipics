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
    
    var indexNo:Int = 0
    
    var deleteCatalogueViewModel: DeleteCatalogViewModel = DeleteCatalogViewModel()
    
    var tempMemoryImages: [UIImage] = []
    
    
    //let activityIndicator = UIActivityIndicatorView(style: .medium)
    
    let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.color = .gray
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    
    let photoActivityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.color = .systemOrange
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    
    var isPaginating = false
    var currentPage = 1
    
    var isPaginatingImage = false
    var currentImagePage = 1
    
    
    let emptyView = EmptyCollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        catalogueCollView.delegate = self
        catalogueCollView.dataSource = self
        
        catalogueCollView.register(UINib(nibName: "NewCatCollViewCell", bundle: nil), forCellWithReuseIdentifier: "NewCatView")
        
        
        photoCollView.dataSource = self
        photoCollView.delegate = self
        
        photoCollView.register(UINib(nibName: "ImageCatalogueViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageCataCell")
        
        
        settingUpAllFonts()
        
        
        
        catalogueCollView.reloadData()
        catalogueCollView.layoutIfNeeded()
        activityIndicator.center = CGPoint(x: catalogueCollView.contentSize.width - 10, y: catalogueCollView.bounds.height / 2)
        
        
        catalogueCollView.addSubview(activityIndicator)
        
        
        photoActivityIndicator.center = CGPoint(x: photoCollView.bounds.width / 2, y: photoCollView.contentSize.height - 10)
        photoCollView.addSubview(photoActivityIndicator)
        
        
        loadAllCatalogueData()
        setupEmptyView()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let savedCatalogueId = UserDefaults.standard.string(forKey: "catalogueId") {
        
            loadAllCatalogueData()
        } else {
            
        }
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        activityIndicator.center = CGPoint(x: catalogueCollView.contentSize.width + 30, y: catalogueCollView.bounds.height / 2)
        
        photoActivityIndicator.center = CGPoint(x: photoCollView.bounds.width / 2, y: photoCollView.contentSize.height - 20)
    }
    
    
    
    @IBAction func previousView(_ sender: Any) {
        
        UserDefaults.standard.removeObject(forKey: "selectedIndexRowCatalogue")
        
        navigationController?.popViewController(animated: true)
    }
    
    
    private func settingUpAllFonts() {
        uploadImgBtn.titleLabel?.font = UIFont(name: textInputStyle.latoBold.rawValue, size: 15)
        createCatalogBtn.titleLabel?.font = UIFont(name: textInputStyle.latoBold.rawValue, size: 15)
        
        myCatalogue.font = UIFont(name: textInputStyle.latoBold.rawValue, size: 19)
    }
    
    
    
    func loadAllCatalogueData() {
        catalogueListingViewModel.requestModel.limit = "10"
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
                        
                        if UserDefaults.standard.object(forKey: "selectedIndexRowCatalogue") != nil {
                            let selectedIndex = UserDefaults.standard.integer(forKey: "selectedIndexRowCatalogue")
                            self.selectedIndexPath = IndexPath(row: selectedIndex, section: 0)
                        } else {
                            
                            
                            self.selectedIndexPath = IndexPath(row: 0, section: 0)
                        }
                        
                        
                        guard let savedCatalogueId = UserDefaults.standard.string(forKey: "catalogueId") else {
                            return
                        }
                        
                        
                        
                        self.loadAllImageCatalogue(catalogueCode: savedCatalogueId)
                        
                        
                        DispatchQueue.main.async {
                            if let selectedIndexPath = self.selectedIndexPath {
                                self.catalogueCollView.scrollToItem(at: selectedIndexPath, at: .centeredHorizontally, animated: true)
                            }
                        }
                        
                        
                        self.catalogueCollView.reloadData()
                        self.photoCollView.reloadData()
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
        catalogueImageListViewModel.requestModel.limit = "10"
        catalogueImageListViewModel.requestModel.offset = "1"
        
       // startCustomLoader()
        
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
                        
                        self.emptyView.isHidden = false
                        
                       // self.stopCustomLoader()
                        return
                    }
                    
                    self.imageCount = value
                    
                    
                    if self.imageCount.isEmpty || self.imageCount.count == 0 {
                        print("The Image count is 0")
                        self.photoCollView.isHidden = true
                        self.imageCache.removeAll() // ✅ Clear cache
                        self.photoCollView.isHidden = true
                        self.emptyView.isHidden = false
                    } else {
                        self.emptyView.isHidden = true
                        print("Image count is there", self.imageCount.count)
                        
                    }
                    
                    
                    
                    self.photoCollView.reloadData()
                   // self.stopCustomLoader()
                    
                case .heyStop:
                    print("Error")
                    //self.stopCustomLoader()
                }
            }
        }
    }
    
    func setupEmptyView() {
    
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        
        photoCollView.addSubview(emptyView)
        
        emptyView.noCatLbl.text = "No Catalogue Image Found!"
        emptyView.addSomeCat.text = "Add Some Catalogue Image"
        
        emptyView.addBtn.isHidden = true
        
        
        emptyView.imgWidthConstraint.constant = 170
        emptyView.imgHeightConstraint.constant = 130
        emptyView.layoutIfNeeded()
        
        NSLayoutConstraint.activate([
            emptyView.centerXAnchor.constraint(equalTo: photoCollView.centerXAnchor),
            emptyView.topAnchor.constraint(equalTo: photoCollView.topAnchor, constant: 120)
        ])
        
       // emptyView.settingUpConstraints()
    }
    
    
    
    
    
    
    
    @IBAction func uploadImgBtnAction(_ sender: Any) {
        let webView = WebViewController()
        navigationController?.pushViewController(webView, animated: true)
    }
    
    
    
    
    @IBAction func createCatalogAction(_ sender: Any) {
        
        let newCat = AddContactViewController()
        newCat.isCatalogueView = true
        newCat.txtFieldPlaceHolder = "Enter Catalogue Name"
        newCat.addCataText = "Create a Catalogue"
        newCat.createCataTxt = "Create a catalogue and add users to share your"
        newCat.favImgLbl = "favourite images"
        
        self.navigationController?.pushViewController(newCat, animated: true)
        
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





