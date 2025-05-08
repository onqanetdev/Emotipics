//
//  AllCataloguesViewController.swift
//  Emotipics
//
//  Created by Onqanet on 12/03/25.
//

import UIKit

class AllCataloguesViewController: UIViewController, DeleteCatalogDelegate {
    
    
    @IBOutlet weak var backGroundView: UIView! {
        didSet{
            backGroundView.layer.cornerRadius = 25
            backGroundView.clipsToBounds = true
        }
    }
    
    
    @IBOutlet weak var catalogueCollView: UICollectionView!
    
    
    @IBOutlet weak var scrollViewHeight: NSLayoutConstraint!
    
    
    
    @IBOutlet weak var myCatalogueLbl: UILabel!
    
    @IBOutlet weak var sortByLbl: UILabel!
    
    private var floatingBtn: FloatingBtn = {
        let btn = FloatingBtn()
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    
    @IBOutlet weak var myCatalogueSubLbl: UILabel!
    
    
    //Boolean View for registering Cell
    var isImageCell: Bool = false
    
    
    
    //Taking all constraints for all
    
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    
    
    var dynamicHeight: CGFloat = 0
    
    var catalogueListingViewModel:CatalogueListingViewModel = CatalogueListingViewModel()
    
//    var activityIndicator: UIActivityIndicatorView = {
//        let indicator = UIActivityIndicatorView(style: .large)
//        indicator.color = .systemBlue
//        indicator.hidesWhenStopped = true
//        return indicator
//    }()
//    
    
    
    
    @IBOutlet weak var contentView: UIView!
    
    
    @IBOutlet weak var headerView: UIView!
    
    
    var indexNo:Int = 0
    var tempMemory:[DataM] = []
    var deleteCatalogueViewModel: DeleteCatalogViewModel = DeleteCatalogViewModel()
    
    let emptyViewForContacts = EmptyCollView()
    // let emptyViewForCatalogueView = EmptyCollView()
    
    var catalogueImageListViewModel: CatalogueImageListViewModel = CatalogueImageListViewModel()
    
    var receivedCatalogueCode = ""
    var imageCount:[ImageData] = []
    
    var imagePathName = ""
    
    
    var imageDeleteViewModel: DeleteImageViewModel = DeleteImageViewModel()
    var imageCode = 0
    var imageIndex = 0
    
    
    private var loaderView: ImageLoaderView?
    
    
    
    var imageCache = [String: UIImage]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        catalogueCollView.dataSource = self
        catalogueCollView.delegate = self
        
        if  isImageCell {
            //print("This is true")
            myCatalogueLbl.text = "Project Files"
            myCatalogueSubLbl.isHidden = false
            catalogueCollView.register(UINib(nibName: "ImageCatalogueViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageCataCell")
        } else {
            catalogueCollView.register(UINib(nibName: "EntryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
            myCatalogueSubLbl.isHidden = true
        }
        
        
        
        myCatalogueLbl.font = UIFont(name: textInputStyle.latoBold.rawValue, size: 17)
        sortByLbl.font = UIFont(name: textInputStyle.latoRegular.rawValue, size: 15)
        addPlusIcon()
        
        
        
        
        
        
        if isImageCell {
            // print("Hello From ViewDidLoad from Image Cell True")
            
            if let catalogueId = UserDefaults.standard.string(forKey: "catalogueId") {
                print("Catalogue ID: \(catalogueId)")
                imagelistViewModel(catalogueCode: catalogueId)
            }
            
        } else {
            
            reloadAllData()
            updateScrollViewHeight()
        }
        
        //setupActivityIndicator()
        emptyViewForContacts.isHidden = true
        
        setupEmptyViewForContacts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if isImageCell{
            
            if let catalogueId = UserDefaults.standard.string(forKey: "catalogueId") {
                print("Catalogue ID: \(catalogueId)")
                imagelistViewModel(catalogueCode: catalogueId)
            }
            
            
        } else {
            reloadAllData()
        }
    }
    
    func reloadAllData(){
        catalogueListingViewModel.requestModel.limit = "50"
        catalogueListingViewModel.requestModel.offset = "1"
        catalogueListingViewModel.requestModel.sort_folder = "DESC"
        catalogueListingViewModel.requestModel.type_of_list = "catalog_lists"
        
       // activityIndicator.startAnimating()
        startCustomLoader()
        
        catalogueListingViewModel.catalogueListing(request: catalogueListingViewModel.requestModel) { result in
            DispatchQueue.main.async { [self] in
               // self.activityIndicator.stopAnimating()
                self.stopCustomLoader()
                switch result {
                case .goAhead:
                    print("Catalogue View Model from AllCataloguesViewController")
                    //table View Reload Data
                    self.catalogueCollView.reloadData()
                    
                    DispatchQueue.main.async { [self] in
                        guard let value = self.catalogueListingViewModel.responseModel?.data else {
                            return
                        }
                        
                        self.tempMemory = value
                        catalogueCollView.reloadData()
                        if tempMemory.isEmpty || tempMemory.count == 0{
                            emptyViewForContacts.isHidden = false
                        } else {
                            emptyViewForContacts.isHidden = true
                        }
                        
                        
                        
                    }
                    
                    
                    //Calculating the height of catalogue cell
                    let sumHeight = (Int(dynamicHeight) * (catalogueListingViewModel.responseModel?.data?.count ?? 1)) / 2
                    
                    
                    if let countData = catalogueListingViewModel.responseModel?.data?.count {
                        print("Count data 👉🏾 👉🏾 👉🏾 👉🏾 👉🏾 👉🏾", countData)
                        if countData % 2 == 0{
                            let height:CGFloat = CGFloat(sumHeight)
                            self.collectionViewHeight.constant = height + 120
                           scrollViewHeight.constant = collectionViewHeight.constant + 300
                            
                            
                            
                        } else {
                            let height:CGFloat = CGFloat(sumHeight)
                            self.collectionViewHeight.constant = height + 120
                            scrollViewHeight.constant = collectionViewHeight.constant + 370
                        }
                    
                        
                    } else {
                        
                    }
                    //Ending of the calculation of the cell
                    
                    
                case .heyStop:
                    print("Error")
                }
                
                
            }
            
            
        }
    }
    
    
    
    func imagelistViewModel(catalogueCode: String){
        
        catalogueImageListViewModel.requestModel.catalog_code = catalogueCode
        catalogueImageListViewModel.requestModel.limit = "50"
        catalogueImageListViewModel.requestModel.offset = "1"
        
        //activityIndicator.startAnimating()
        startCustomLoader()
        catalogueImageListViewModel.catalogueImageListViewModel(request: catalogueImageListViewModel.requestModel) { result in
            DispatchQueue.main.async { [self] in
                //self.activityIndicator.stopAnimating()
                self.stopCustomLoader()
                switch result {
                case .goAhead:
                

                    DispatchQueue.main.async { [self] in
                        guard let value = self.catalogueImageListViewModel.responseModel?.data else {
                            
                            emptyViewForContacts.isHidden = false
                            emptyViewForContacts.addBtn.isHidden = true
                            emptyViewForContacts.addSomeCat.text = "Add Some Images"
                            emptyViewForContacts.noCatLbl.text = "No Image to Show"
                            catalogueCollView.isHidden = true
                            return
                        }
                       
                        self.imageCount = value
                        //catalogueCollView.reloadData()
                        if imageCount.isEmpty || imageCount.count == 0{
                            print("my image count is 0 💀 💀 💀 💀")
                            emptyViewForContacts.isHidden = false
                            emptyViewForContacts.addBtn.isHidden = true
                            catalogueCollView.isHidden = true
                            
                        } else {
                            print("Image count is there", imageCount.count)
                            emptyViewForContacts.isHidden = true
                            catalogueCollView.isHidden = false
                            
                            //calculation of cell size
                            
                            let sumHeight = (Int(dynamicHeight) * (imageCount.count)) / 2
                            if let countData = catalogueImageListViewModel.responseModel?.data?.count {
                                
                                if countData % 2 == 0{
                                    let height:CGFloat = CGFloat(sumHeight)
                                    self.collectionViewHeight.constant = height + 100
                                    scrollViewHeight.constant = collectionViewHeight.constant + 370
                                } else {
                                    let height:CGFloat = CGFloat(sumHeight)
                                    self.collectionViewHeight.constant = height + 120 + 70
                                    scrollViewHeight.constant = collectionViewHeight.constant + 370
                                }
                                
                                
                            } else {
                                
                            }
                            //Ending Of calculation of cell
                        }
                        
                        self.catalogueCollView.reloadData()
                        
                    }
                    
        
                    
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
    
//    
//    func setupActivityIndicator() {
//        view.addSubview(activityIndicator)
//        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
//        
//        activityIndicator.transform = CGAffineTransform(scaleX: 3.0, y: 3.0)
//        
//        NSLayoutConstraint.activate([
//            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
//        ])
//    }
//    
    
    func updateScrollViewHeight() {
        // Force collectionView layout update
        catalogueCollView.layoutIfNeeded()
        
        var height:CGFloat = dynamicHeight * 13
        collectionViewHeight.constant = height
        scrollViewHeight.constant = collectionViewHeight.constant + 170
        
        print("The Dynamic height is ", dynamicHeight)
        
        
    }
    
    
    @IBAction func backToCatalogue(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
        
    }
    
    func addPlusIcon(){
        // floatingBtn.addSubview(Flo)
        view.addSubview(floatingBtn)
        
        if isImageCell {
            floatingBtn.setTarget(self, action: #selector(addWebView), for: .touchUpInside)
        } else {
            floatingBtn.setTarget(self, action: #selector(addNewCatalogue), for: .touchUpInside)
        }
        
        NSLayoutConstraint.activate([
            floatingBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -90),
            floatingBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            floatingBtn.heightAnchor.constraint(equalToConstant: 60),
            floatingBtn.widthAnchor.constraint(equalToConstant: 60)
        ])
        
    }
    
    
    
    @objc func addWebView() {
        let webView = WebViewController()
        navigationController?.pushViewController(webView, animated: true)
    }
    
    @objc func addNewCatalogue() {
        //AddCatalogueApiCaller.addCatalogueApiCaller(folderName: "Dev2 Catalogue")
        let nextView = AddContactViewController()
        nextView.isCatalogueView = true
        nextView.txtFieldPlaceHolder = "Enter Catalogue Name"
        nextView.addCataText = "Create a Catalogue"
        nextView.createCataTxt = "Create a catalogue and add users to share your"
        nextView.favImgLbl = "favourite images"
        
        navigationController?.pushViewController(nextView, animated: true)
        
    }
    
    
    func deleteCatalogueFunction(pin: Int){
        guard let item = tempMemory[pin].catalogue_uuid else {
            return
        }
        
        
        
       // self.activityIndicator.startAnimating()
        startCustomLoader()
        deleteCatalogueViewModel.requestModel.UUID = item
        deleteCatalogueViewModel.deleteCatalogViewModel(request: deleteCatalogueViewModel.requestModel) { result in
            DispatchQueue.main.async {
                //self.activityIndicator.stopAnimating()
                self.stopCustomLoader()
                switch result {
                case .goAhead:
                    print("Catalogue View Model from Catalogue View Controller")
                    self.tempMemory.remove(at: pin)
                    self.catalogueCollView.reloadData()
                    
                    if self.tempMemory.isEmpty {
                        self.emptyViewForContacts.isHidden = false
                        self.catalogueCollView.isHidden = true
                    } else {
                        self.emptyViewForContacts.isHidden = true
                        self.catalogueCollView.isHidden = false
                        
                        
                        //Calculating the height of catalogue cell
                        let sumHeight = (Int(self.dynamicHeight) * (self.catalogueListingViewModel.responseModel?.data?.count ?? 1)) / 2
                        
                        
                        if let countData = self.catalogueListingViewModel.responseModel?.data?.count {
                            
                            if countData % 2 == 0{
                                let height:CGFloat = CGFloat(sumHeight)
                                self.collectionViewHeight.constant = height
                                self.scrollViewHeight.constant = self.collectionViewHeight.constant + 370
//                                self.scrollViewHeight.constant = self.collectionViewHeight.constant + 1000
        
                            } else {
                                let height:CGFloat = CGFloat(sumHeight)
                                self.collectionViewHeight.constant = height + 120
                                self.scrollViewHeight.constant = self.collectionViewHeight.constant + 370
                            }
                        
                            
                        } else {
                            
                        }
                        //Ending of the calculation of the cell
                        
                        
                    }
                case .heyStop:
                    print("Error")
                }
                
                
            }
            
            
        }
    }
    
    
    
    func setupEmptyViewForContacts() {
        
        emptyViewForContacts.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(emptyViewForContacts)
        
        
        emptyViewForContacts.addBtn.addTarget(self, action: #selector(addNewCatalogue), for: .touchUpInside)
        
        // Set constraints
        NSLayoutConstraint.activate([
            emptyViewForContacts.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            emptyViewForContacts.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyViewForContacts.widthAnchor.constraint(equalTo: view.widthAnchor),
            emptyViewForContacts.heightAnchor.constraint(equalToConstant: 252) // adjust as needed
        ])
        
        // Call method to setup inner views
        emptyViewForContacts.settingUpConstraints()
    }
    
    
    @objc func deleteCatalogueBtnAction(_ sender: UIButton) {
        
        indexNo = sender.tag
        
        //deleteCatalogGlobalPopUp()
        self.deleteCatalogPopUp()
        
        
        
    }
    
    func deleteCatalogPopUp() {
        let errorPopup = DeleteCatalogPopVC(nibName: "DeleteCatalogPopVC", bundle: nil)
        
        errorPopup.modalPresentationStyle = .overCurrentContext
        errorPopup.modalTransitionStyle = .crossDissolve
        // errorPopup.delegate = self
        errorPopup.onCompletion = { [weak self] result in
            switch result {
            case .YES:
                print("✅ User confirmed delete!")
                
                // Wait for popup to finish dismissing before presenting the next one
                errorPopup.dismiss(animated: true) {
                    // self?.deleteCatalogPopUp()
                    self?.deleteCatalogGlobalPopUp()
                    print("Print Nothing")
                }
                
            case .NO:
                print("User canceled delete.")
                errorPopup.dismiss(animated: true, completion: nil)
            case .SHARE:
                print("Sharing from Catalog")
                
                errorPopup.dismiss(animated: true) {
                    self?.presentShareScreen()
                }
            case .RENAME:
                print("RENAME")
                errorPopup.dismiss(animated: true){
                    self?.presentRenameCatalogueScreen()
                }
            }
            
            
        }
        
        self.present(errorPopup, animated: true)
    }
    
    func deleteCatalogGlobalPopUp() {
        let errorPopup = DeleteCatalogueGlobalPopUp(nibName: "DeleteCatalogueGlobalPopUp", bundle: nil)
        errorPopup.modalPresentationStyle = .overCurrentContext
        errorPopup.modalTransitionStyle = .crossDissolve
        errorPopup.delegate = self
        self.present(errorPopup, animated: true)
        
        
    }
    
    
    func deletePopup(){
        deleteCatalogueFunction(pin: indexNo)
    }
    
    
    func presentShareScreen() {
        
        let shareInfo = SharedInformationVC(nibName: "SharedInformationVC", bundle: nil)
        shareInfo.modalPresentationStyle = .overCurrentContext
        shareInfo.modalTransitionStyle = .crossDissolve
        shareInfo.delegate = self
        if let sharedList = catalogueListingViewModel.responseModel?.data?[indexNo].sharedcatalog,
           let catalogName = catalogueListingViewModel.responseModel?.data?[indexNo].catalog_name,
           let catalogcode = catalogueListingViewModel.responseModel?.data?[indexNo].catalog_code
        {
            
            shareInfo.temporaryMemory = sharedList
            shareInfo.catalogueNameText = catalogName
            
            shareInfo.catalogCode = catalogcode
            
        } else {
            AlertView.showAlert("Warning!", message: "There is no memory", okTitle: "OK")
        }
        
        
        self.present(shareInfo, animated: true, completion: nil)
    }
    

}






extension AllCataloguesViewController: SharedInformationDelegate {
    func didTapProceed() {
        let shareVC = SharingContactListVC(nibName: "SharingContactListVC", bundle: nil)
        shareVC.modalPresentationStyle = .fullScreen
        guard let catalogDataGet = catalogueListingViewModel.responseModel?.data else {
            AlertView.showAlert("Warning!", message: "There is No data in catalogue", okTitle: "OK")
            return
        }
        shareVC.catalogData = catalogDataGet
        shareVC.shareIndex = indexNo
        self.present(shareVC, animated: true, completion: nil)
    }
    
    
}





extension AllCataloguesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //return catalogueListingViewModel.responseModel?.data?.count ?? 0
        if isImageCell {
            //return 5
            return imageCount.count
        } else {
            return tempMemory.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if isImageCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCataCell", for: indexPath) as! ImageCatalogueViewCell
            cell.layer.cornerRadius = 15
            cell.clipsToBounds = true
            
            cell.imageBtnDelete.tag = indexPath.row
            cell.imageBtnDelete.addTarget(self, action: #selector(deleteImage(_:)), for: .touchUpInside)
            
            if let imgPath = imageCount[indexPath.row].path,
               let imgName = imageCount[indexPath.row].img_name {
                let imagePath = imgPath + imgName
                print("Image Path:", imagePath)


//                
                if let cachedImage = imageCache[imagePath] {
                        cell.imgViewColl.image = cachedImage
                        cell.stopCustomLoader()
                } else {
                    cell.imgViewColl.image = nil // Optional: clear image to avoid showing old image in reused cell
                    cell.startCustomLoader()
                    
                    if let urlImage = URL(string: imagePath) {
                        URLSession.shared.dataTask(with: urlImage) { data, _, _ in
                            guard let data = data, let image = UIImage(data: data) else { return }
                            
                            DispatchQueue.main.async {
                                self.imageCache[imagePath] = image // Cache the image
                                if let currentCell = collectionView.cellForItem(at: indexPath) as? ImageCatalogueViewCell {
                                    currentCell.imgViewColl.image = image
                                    currentCell.stopCustomLoader()
                                }
                            }
                        }.resume()
                    }
                }
                
            }

            return cell
            
        
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! EntryCollectionViewCell
            cell.layer.cornerRadius = 15
            cell.clipsToBounds = true
            
            
            cell.projectFilesLbl.text = tempMemory[indexPath.row].catalog_name
            cell.noOfFiles.text = "\(tempMemory[indexPath.row].totalcatalogfile ?? 0)"
            cell.fiveGbLbl.text = tempMemory[indexPath.row].catalogimagesize
            
            cell.moreFeaturesBtn.tag = indexPath.row
            cell.moreFeaturesBtn.addTarget(self, action: #selector(deleteCatalogueBtnAction(_:)), for: .touchUpInside)
            
            
            return cell
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfItemsPerRow: CGFloat = 2
        let spacingBetweenCells: CGFloat = 10
        let sectionInsets: CGFloat = 10 // Reduced from 20 to avoid width issues
        
        let totalSpacing = (numberOfItemsPerRow - 1) * spacingBetweenCells + (sectionInsets * 2)
        let availableWidth = collectionView.bounds.width - totalSpacing
        
        let cellWidth = availableWidth / numberOfItemsPerRow
        
        
        
        if isImageCell {
            //print("Image Cell is true")
            dynamicHeight = cellWidth * 1.0
            return CGSize(width: max(0, cellWidth), height: cellWidth * 1.0)
        } else {
            //print("Image cell is false")
            dynamicHeight = 120
            return CGSize(width: max(0, cellWidth), height: 120)
        }
        
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10) // Reduce left & right insets
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let layout = catalogueCollView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.invalidateLayout() // Ensure the layout updates
        }
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //print("Image Path is ", imagePathName)
        if isImageCell {
            if let imgPath = imageCount[indexPath.row].path,
               let imgName = imageCount[indexPath.row].img_name {
                let imagePath = imgPath + imgName
                print("Selected Image Path: \(imagePath)")
            }
        } else {
            print("Selected entry cell at index: \(indexPath.row)")
            
            let imageViewController = AllCataloguesViewController()
            imageViewController.isImageCell = true
        
            
            let catalogueId = tempMemory[indexPath.row].catalog_code
            let userCode = tempMemory[indexPath.row].owner_detials?.code
            //Temp catalogue
            let tappedCatalogueName = tempMemory[indexPath.row].catalog_name
            
            
            if let catalogueId = catalogueId {
                UserDefaults.standard.set(catalogueId, forKey: "catalogueId")
            }

            if let userCode = userCode {
                UserDefaults.standard.set(userCode, forKey: "userCode")
            }
            
            
            navigationController?.pushViewController(imageViewController, animated: true)
        }
    }
}








