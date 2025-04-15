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
    
    var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .systemBlue
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    
    
    
    @IBOutlet weak var contentView: UIView!
    
    
    @IBOutlet weak var headerView: UIView!
    
    
    var indexNo:Int = 0
    var tempMemory:[DataM] = []
    var deleteCatalogueViewModel: DeleteCatalogViewModel = DeleteCatalogViewModel()
    
   let emptyViewForContacts = EmptyCollView()
   // let emptyViewForCatalogueView = EmptyCollView()
    
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
        
        //        catalogueCollView.register(UINib(nibName: "EntryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        
        
        myCatalogueLbl.font = UIFont(name: textInputStyle.latoBold.rawValue, size: 17)
        sortByLbl.font = UIFont(name: textInputStyle.latoRegular.rawValue, size: 15)
        addPlusIcon()
        
        
        
        updateScrollViewHeight()
        
        
        if isImageCell {
           // print("Hello From ViewDidLoad from Image Cell True")
            
        } else {
            // print("Hello from viewDidload from image cell  false")
        }
        
        setupActivityIndicator()
        reloadAllData()
    
        emptyViewForContacts.isHidden = true
        
        setupEmptyViewForContacts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reloadAllData()
    }
    
    func reloadAllData(){
        catalogueListingViewModel.requestModel.limit = "10"
        catalogueListingViewModel.requestModel.offset = "1"
        catalogueListingViewModel.requestModel.sort_folder = "DESC"
        catalogueListingViewModel.requestModel.type_of_list = "catalog_lists"
        
        activityIndicator.startAnimating()
        
        catalogueListingViewModel.catalogueListing(request: catalogueListingViewModel.requestModel) { result in
            DispatchQueue.main.async { [self] in
                self.activityIndicator.stopAnimating()
                
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
                        if tempMemory.isEmpty {
                            emptyViewForContacts.isHidden = false
                        } else {
                            emptyViewForContacts.isHidden = true
                        }
                        
                        
                        
                   }
                    
                    
                    
                    let sumHeight = (Int(dynamicHeight) * (catalogueListingViewModel.responseModel?.data?.count ?? 1)) / 2
                    
                    
                    if let countData = catalogueListingViewModel.responseModel?.data?.count {
                        
                        if countData % 2 == 0{
                            let height:CGFloat = CGFloat(sumHeight)
                            self.collectionViewHeight.constant = height
                            scrollViewHeight.constant = collectionViewHeight.constant + 370
                        } else {
                            let height:CGFloat = CGFloat(sumHeight)
                            self.collectionViewHeight.constant = height + 120
                            scrollViewHeight.constant = collectionViewHeight.constant + 370
                        }
                        
                        
                        
                        
                        
                        
                    } else {
                        
                    }
                    
                    
                    
                case .heyStop:
                    print("Error")
                }
                
                
            }
            
            
        }
    }
    
    func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        activityIndicator.transform = CGAffineTransform(scaleX: 3.0, y: 3.0)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }

    
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
        
        
        
        self.activityIndicator.startAnimating()
        deleteCatalogueViewModel.requestModel.UUID = item
        deleteCatalogueViewModel.deleteCatalogViewModel(request: deleteCatalogueViewModel.requestModel) { result in
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                
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
           let catalogName = catalogueListingViewModel.responseModel?.data?[indexNo].catalog_name{
            
            shareInfo.temporaryMemory = sharedList
            shareInfo.catalogueNameText = catalogName
            
        } else {
            AlertView.showAlert("Warning!", message: "There is no memory", okTitle: "OK")
        } 
        
        
        self.present(shareInfo, animated: true, completion: nil)
    }
    
    
    
    
//    func setupEmptyViewForCatalogues() {
//        
//        emptyViewForCatalogueView.translatesAutoresizingMaskIntoConstraints = false
//        contentView.addSubview(emptyViewForCatalogueView)
//        
//        // Set constraints
//        NSLayoutConstraint.activate([
//            emptyViewForCatalogueView.topAnchor.constraint(equalTo: sharedCatalogHeaderView.bottomAnchor),
//            emptyViewForCatalogueView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            emptyViewForCatalogueView.widthAnchor.constraint(equalTo: view.widthAnchor),
//            emptyViewForCatalogueView.heightAnchor.constraint(equalToConstant: 300) // adjust as needed
//        ])
//        
//        // Call method to setup inner views
//        emptyViewForCatalogueView.settingUpConstraints()
//    }
//    
    
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
        return tempMemory.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if isImageCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCataCell", for: indexPath) as! ImageCatalogueViewCell
            cell.layer.cornerRadius = 15
            cell.clipsToBounds = true
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! EntryCollectionViewCell
            cell.layer.cornerRadius = 15
            cell.clipsToBounds = true
            

            cell.projectFilesLbl.text = tempMemory[indexPath.row].catalog_name
            cell.noOfFiles.text = tempMemory[indexPath.row].total_files
            cell.fiveGbLbl.text = tempMemory[indexPath.row].file_storage
            
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

}








