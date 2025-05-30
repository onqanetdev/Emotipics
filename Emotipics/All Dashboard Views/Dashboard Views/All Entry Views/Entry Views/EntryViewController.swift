//
//  EntryViewController.swift
//  Emotipics
//
//  Created by Onqanet on 06/03/25.
//

import UIKit
import Charts


class EntryViewController: UIViewController , UpdateUI,SharedInformationDelegate{
    
    
    @IBOutlet weak var rotateBtn: UIButton!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var welcomeBackLbl: UILabel!{
        didSet{
            welcomeBackLbl.font = UIFont(name: "Lato-Bold", size: 18)
        }
    }
    
    private let sideMenuManager = SideMenuManager()
    
    //The Oval Card
    
    @IBOutlet weak var cardView: UIView!{
        didSet{
            cardView.layer.cornerRadius = 25
            cardView.clipsToBounds = true
        }
    }
    
    
    @IBOutlet weak var CatalogueLbl: UILabel!{
        didSet{
            //1. set the font family for the label
            
        }
    }
    
    
    @IBOutlet weak var fileColView: UICollectionView!{
        didSet{
            fileColView.isHidden = true
        }
    }
    
    //MARK: 1500 height of the scroll view
    @IBOutlet weak var contentViewHeight: NSLayoutConstraint!
    
 
    @IBOutlet weak var blueCircle: UIView! {
        didSet {
            blueCircle.layer.cornerRadius = blueCircle.frame.size.width / 2
            blueCircle.clipsToBounds = true
        }
    }
        
    //Fonts of  lato-regular
    @IBOutlet weak var totalStorageLbl: UILabel!
    @IBOutlet weak var usedFromLbl: UILabel!
    @IBOutlet weak var viewAllLbl: UIButton!
    @IBOutlet weak var contactsViewAllLbl: UIButton! {
        didSet {
            contactsViewAllLbl.setTitleColor(.black, for: .normal)
        }
    }
    
    //Fonts for lato - bold
    
    @IBOutlet weak var fifteenGbLbl: UILabel!
   // @IBOutlet weak var getHundredGbLbl: UILabel!
    
    
    @IBOutlet weak var myContactsLbl: UILabel!
    
    
    
    @IBOutlet weak var photosLbl: UILabel!
    
    
    @IBOutlet weak var nineGbLbl: UILabel!
    
    @IBOutlet weak var contactsTblView: UITableView!{
        didSet {
            contactsTblView.isHidden = true
        }
    }
    
    @IBOutlet weak var heightsOfContactsiTblView: NSLayoutConstraint!
    
    
    
    
    @IBOutlet weak var bellIconOutlet: UIButton!{
        didSet {
            bellIconOutlet.layer.cornerRadius = 25
            bellIconOutlet.clipsToBounds = true
        }
    }
    
    
    @IBOutlet weak var moreBtnLbl: UIButton!{
        didSet{
            moreBtnLbl.layer.cornerRadius = 25
            moreBtnLbl.clipsToBounds = true
        }
    }
    
    //Implementing the circular view
    var circularView: Circular!
    
    var collectionHeight:Int = 110
    
    var indexNo:Int = 0
    
    private var pertentageLbl:UILabel = {
        let label = UILabel()
        label.text = "60%"
        label.font = UIFont(name: "Jost-Medium", size: 20)
        label.textColor = #colorLiteral(red: 0.6705882353, green: 0.8235294118, blue: 0.9843137255, alpha: 1)
        return label
    }()
    
    
    //Add Contact View Model
    
    var addContactViewModel: AddContactViewModel = AddContactViewModel()
    
    var contactsViewModel: AllContactsViewModel = AllContactsViewModel()
    
    var catalogueListingViewModel: CatalogueListingViewModel = CatalogueListingViewModel()
    

    
    let emptyView = EmptyCollView()
    let emptyViewForContacts = EmptyCollView()
    
    @IBOutlet weak var catalogueTitleView: UIView!
    
    
    @IBOutlet weak var contentView: UIView!
    
    
    @IBOutlet weak var myContactsHeaderView: UIView!
    
    //MARK: Shared Catalogue coll view
    
    @IBOutlet weak var sharedCatalogueCollView: UICollectionView!
    
    
    
    @IBOutlet weak var sharedImageCollView: UICollectionView!
    
    
    // Height for Shared Catalogue and Shared Image with me
    
    
    
    @IBOutlet weak var sharedCatalogueHeight: NSLayoutConstraint!
    
    
 
    @IBOutlet weak var sharedImageCollViewHeight: NSLayoutConstraint!
    
    var deleteCatalogueViewModel: DeleteCatalogViewModel = DeleteCatalogViewModel()
    
    
    var tempMemory:[DataM] = []
    
    var sharedCataTempMemory:[DataM] = []
    
    
    var userName = ""
    
    public var loaderView: ImageLoaderView?
    
    
    var dashboardViewModel: DashboardViewModel = DashboardViewModel()
    
    private var totalStorageGB:  Double = .zero
    private var remainingStorageGB: Double = .zero
    private var usedPercent: Double {
        guard totalStorageGB > 0 else { return 0 }
        return (totalStorageGB - remainingStorageGB) / totalStorageGB * 100
    }
    
    
    var dynamicHeight: CGFloat = 0
    
    
    
    var sharedCatalogueViewModel:CatalogueListingViewModel = CatalogueListingViewModel()
   
    
    //MARK: Image Loading and Storing
    var sharedImageByMeViewModel: SharedImageByMeViewModel = SharedImageByMeViewModel()
    
    var sharedImageData:[SharedData] = []
    
    
    var imageCache: [String: UIImage] = [:]

    
    
    @IBOutlet weak var shareWithMeViewHeight: NSLayoutConstraint!
    
    
    
    var isSkeletonVisible = true

    
    
    // MARK: All The Heights
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        // Setting Ups The font
    
        if let savedName = UserDefaults.standard.string(forKey: "userName") {
            // print("Welcome, \(savedName)")
            userName = savedName
        }
    
        welcomeBackLbl.text = "Welcome Back, " + userName
        
        userExists()
        
        settingUpFonts()

        rotateBtn.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        
        fileColView.delegate = self
        fileColView.dataSource = self
        
        fileColView.register(UINib(nibName: "EntryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        
       // showSkeleton()
        
        
        // Table Views for contact Listing
        contactsTblView.dataSource = self
        contactsTblView.delegate = self
        
        contactsTblView.register(UINib(nibName: "EntryTableViewCell", bundle: nil), forCellReuseIdentifier: "TableCell")
        
        
        contentViewHeight.constant = 15.35
        
        
        heightsOfContactsiTblView.constant = 70
        contentViewHeight.constant += heightsOfContactsiTblView.constant
        pertentageLbl.translatesAutoresizingMaskIntoConstraints = false
        setupCircularView()
        setupPecentageLbl()
        
        // MARK: Setting up Shared Catalogue & Share Image With Me
        sharedCatalogueCollView.delegate = self
        sharedCatalogueCollView.dataSource = self
        sharedCatalogueCollView.register(UINib(nibName: "EntryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        
        
        
        sharedImageCollView.delegate = self
        sharedImageCollView.dataSource = self
        sharedImageCollView.register(UINib(nibName: "ImageCatalogueViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageCataCell")
        
        sideMenuManager.setup(in: self)
       // setupActivityIndicator()
        
        allCatalogueView()
        
        setupEmptyView()
        
        viewModel()
        setupEmptyViewForContacts()
        
        dashboardStorageDetails()
        
        
        sharedCatalogueList()
        sharedWithMeList()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = false
        //viewModel is for Contacts
        viewModel()
        
        //All Catalogueview is for Catalogue
        allCatalogueView()
        
        
        sharedCatalogueList()
        
        sharedWithMeList()
    }
    

    
    /// Keeps only 0‑9 and decimal point, so "24.94 GB" → "24.94"
    private func numericString(from raw: String) -> String {
        let allowed = CharacterSet(charactersIn: "0123456789.")
        return String(raw.unicodeScalars.filter { allowed.contains($0) })
    }

    
    
    func dashboardStorageDetails() {
        dashboardViewModel.dashboardViewModel { [weak self] result in
            DispatchQueue.main.async {
                guard let self else { return }
                self.stopCustomLoader()

                switch result {
                case .goAhead:
                    // 1. Read raw strings
                    guard
                        let totalRaw     = self.dashboardViewModel.responseModel?.total_size,
                        let remainingRaw = self.dashboardViewModel.responseModel?.remaining_size
                    else {
                        print("❌ API did not return total_size / remaining_size")
                        return
                    }

                    // 2. Clean them → numeric strings
                    let totalClean     = self.numericString(from: totalRaw)
                    let remainingClean = self.numericString(from: remainingRaw)

                    // 3. Convert to Double
                    guard
                        let total = Double(totalClean),
                        let remaining = Double(remainingClean)
                    else {
                        print("❌ Could not convert '\(totalClean)' or '\(remainingClean)' to Double")
                        return
                    }

                    // 4. Store
                    self.totalStorageGB     = total
                    self.remainingStorageGB = remaining
                    
//                    print("Total Storage 🦠🦠🦠🦠🦠", self.totalStorageGB)
//                    print("Remaining Storage 🦠🦠🦠🦠🦠🦠", self.remainingStorageGB )

                    
                    let usedGB = self.totalStorageGB  - self.remainingStorageGB
                    
                    self.fifteenGbLbl.text = String(format: "%.2f", usedGB) + "%"
                    self.nineGbLbl.text = String(format: "%.2f", self.remainingStorageGB) + "%"
                    // 5. Update UI
                    self.setupCircularView(usedPercent: self.usedPercent)

                   // self.setupPecentageLbl()
                case .heyStop:
                    print("Error")
                }
            }
        }
    }
    
    
    
    private func setupCircularView(usedPercent: Double) {
        let freePercent = 100 - usedPercent
        let sampleColor = UIColor(#colorLiteral(red: 0.67, green: 0.82, blue: 0.98, alpha: 1))

        
        
        let circularView = Circular(
            percentages: [usedPercent, freePercent],
            colors: [sampleColor, .systemBlue]
        )
        circularView.translatesAutoresizingMaskIntoConstraints = false
        cardView.addSubview(circularView)

        NSLayoutConstraint.activate([
            circularView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20),
            circularView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 27),
            circularView.widthAnchor.constraint(equalToConstant: 90),
            circularView.heightAnchor.constraint(equalToConstant: 90)
        ])
        
        pertentageLbl.text = String(format: "%.2f", freePercent) + "%"
        // 2. Now the label can be attached safely
           setupPecentageLbl()
       // print("Free Percent Storage is🦠🦠🦠🦠", freePercent)
        //print("Percentage label is 🦠🦠🦠🦠", usedPercent)
        
    }

    
    

    
    

    //MARK: Font Family Settigs
    private func settingUpFonts() {
        //         let inputFont = "Lato-Regular"
        totalStorageLbl.font = UIFont(name: textInputStyle.latoRegular.rawValue, size: 16)
        usedFromLbl.font = UIFont(name: textInputStyle.latoRegular.rawValue, size: 14)
        viewAllLbl.titleLabel?.font = UIFont(name: textInputStyle.latoRegular.rawValue, size: 15)
        contactsViewAllLbl.titleLabel?.font = UIFont(name: textInputStyle.latoRegular.rawValue, size: 17)
        //setting Ups fonts  lato-bold
        fifteenGbLbl.font = UIFont(name: textInputStyle.latoBold.rawValue, size: 28)
        CatalogueLbl.font = UIFont(name: textInputStyle.latoBold.rawValue, size: 17)
       // getHundredGbLbl.font = UIFont(name: textInputStyle.latoBold.rawValue, size: 17)
        myContactsLbl.font = UIFont(name: textInputStyle.latoBold.rawValue, size: 17)
        //setting ups for fonts poppins-regular
        photosLbl.font = UIFont(name: textInputStyle.poppinsRegular.rawValue, size: 13)
//        videosLbl.font = UIFont(name: textInputStyle.poppinsRegular.rawValue, size: 13)
        nineGbLbl.font = UIFont(name: textInputStyle.poppinsRegular.rawValue, size: 13)
//        sixGbLbl.font = UIFont(name: textInputStyle.poppinsRegular.rawValue, size: 13)
        //settings ups for fonts poppins-medium
        
      //  priceTagLbl.font = UIFont(name: textInputStyle.poppinsMedium.rawValue, size: 13)
      //  viewPlansBtn.titleLabel?.font = UIFont(name: textInputStyle.poppinsMedium.rawValue, size: 14)
    }
    
    
    //Setting Up the Circular View
    
    private func setupCircularView() {
        
        let sampleColor:UIColor = #colorLiteral(red: 0.6705882353, green: 0.8235294118, blue: 0.9843137255, alpha: 1)
        let percentages: [Double] = [40.00, 60.00] // Example data percentages
        let colors: [UIColor] = [ sampleColor, .systemBlue] // Example colors
        
        
        circularView = Circular(percentages: percentages, colors: colors)
        circularView.translatesAutoresizingMaskIntoConstraints = false
        
        
        cardView.addSubview(circularView)
        
        
        NSLayoutConstraint.activate([
            circularView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20),
            circularView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 27),
            circularView.widthAnchor.constraint(equalToConstant: 90),
            circularView.heightAnchor.constraint(equalToConstant: 90)
        ])
    }
    
    
    private func setupPecentageLbl() {
        //cardView.addSubview(pertentageLbl)
        pertentageLbl.translatesAutoresizingMaskIntoConstraints = false
        circularView.addSubview(pertentageLbl)

        
        NSLayoutConstraint.activate([
            pertentageLbl.centerXAnchor.constraint(equalTo: circularView.centerXAnchor),
            pertentageLbl.centerYAnchor.constraint(equalTo: circularView.centerYAnchor)
        ])
        
    }
    
    
    
    func setupEmptyView() {
        
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(emptyView)
        
        
        emptyView.addBtn.addTarget(self, action: #selector(createCatalogueList), for: .touchUpInside)
        
        
        // Set constraints
        NSLayoutConstraint.activate([
            emptyView.topAnchor.constraint(equalTo: catalogueTitleView.bottomAnchor),
            emptyView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyView.widthAnchor.constraint(equalTo: view.widthAnchor),
            emptyView.heightAnchor.constraint(equalToConstant: 150) // adjust as needed
        ])
        
        // Call method to setup inner views
        emptyView.settingUpConstraints()
    }
    
    
    func setupEmptyViewForContacts() {
        
        emptyViewForContacts.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(emptyViewForContacts)
        
        emptyViewForContacts.addBtn.setTitle("Add Contacts", for: .normal)
        emptyViewForContacts.noCatLbl.text = "No Contacts Found"
        emptyViewForContacts.addSomeCat.text = "Add Some Contacts to Share"
        
        emptyViewForContacts.addBtn.addTarget(self, action: #selector(addNewContact), for: .touchUpInside)
        
        // Set constraints
        NSLayoutConstraint.activate([
            emptyViewForContacts.topAnchor.constraint(equalTo: myContactsHeaderView.bottomAnchor),
            emptyViewForContacts.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyViewForContacts.widthAnchor.constraint(equalTo: view.widthAnchor),
            emptyViewForContacts.heightAnchor.constraint(equalToConstant: 200) // adjust as needed
        ])
        
        // Call method to setup inner views
        emptyViewForContacts.settingUpConstraints()
    }
    
    
    
    
    @objc func createCatalogueList() {
        let addCatalogueVC = AddContactViewController()
        addCatalogueVC.isCatalogueView = true
        
        addCatalogueVC.txtFieldPlaceHolder = "Enter Catalogue Name"
        addCatalogueVC.addCataText = "Create a Catalogue"
        addCatalogueVC.createCataTxt = "Create a catalogue and add users to share your"
        addCatalogueVC.favImgLbl = "favourite images"
        navigationController?.pushViewController(addCatalogueVC, animated: true)
    }
    
    
    
    @IBAction func allCatalogueAction(_ sender: Any) {
        
        
//        navigationController?.pushViewController(CatalogueViewController(), animated: true)
        
        navigationController?.pushViewController(NewCatalogueVC(), animated: true)
        
    }
    
    @IBAction func bellIconAction(_ sender: Any) {
        
        print("This is my bell Icon")
    }
    
    
    @IBAction func viewAllContacts(_ sender: Any) {
        
        //AddContactApiCaller.addContactApiCaller(email: "kinode3436@buides.com")
        navigationController?.pushViewController(ContactsViewController(), animated: true)
        print("This is my all contacts")
    }
    
    
    
    @IBAction func notificationViewAction(_ sender: Any) {
        let notificationView = GroupListViewController()
        notificationView.notificationView = true
        
        navigationController?.pushViewController(notificationView, animated: true)
        
        
    }
    
    
    
    @IBAction func myProfileView(_ sender: Any) {
        print("My Profile is Showing")
        sideMenuManager.toggleSideMenu()
    }
    
    
    func userExists(){
        let data = KeychainManager.standard.read(service: "com.Emotipics.service", account: "access-token")!
        let accessToken = String(data: data, encoding: .utf8)!
        print("Already Exists Access Token",accessToken)
        
        let dataUser = KeychainManager.standard.read(service: "com.Emotipics.service", account: "UUID")!
        let UuidUser = String(data: dataUser, encoding: .utf8)!
        print("Already Exists uuid is",UuidUser)
    }
    
    
    func deleteScreenPopUp(desiredCode: String) {
        let errorPopup = DeletePopUpVC(nibName: "DeletePopUpVC", bundle: nil)
        //errorPopup.emailText = emailAddTxtFld.text!
        errorPopup.modalPresentationStyle = .overCurrentContext
        errorPopup.modalTransitionStyle = .crossDissolve
        errorPopup.indexOk = desiredCode
        errorPopup.deleteDelegate = self
        self.present(errorPopup, animated: true)
    }
    
    func deleteCatalogPopUp() {
        let errorPopup = DeleteCatalogPopVC(nibName: "DeleteCatalogPopVC", bundle: nil)
        
        errorPopup.modalPresentationStyle = .overCurrentContext
        errorPopup.modalTransitionStyle = .crossDissolve
        guard let catalogDataGet = catalogueListingViewModel.responseModel?.data else {
            AlertView.showAlert("Warning!", message: "There is No data in catalogue", okTitle: "OK")
            return
        }
        errorPopup.catalogData = catalogDataGet
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
                print("User tapped Share.")
                errorPopup.dismiss(animated: true) {
                    self?.presentShareScreen()
                }
                
            case .RENAME:
                errorPopup.dismiss(animated: true) {
                    self?.presentRenameCatalogueScreen()
                }
                
            case .DETAILS:
                print("Details of catalogue has not been filled yet on entry view controller")
            }
        }
        
        self.present(errorPopup, animated: true)
    }
    
    
    
    @objc func popUpFromBottom(_ sender: UIButton) {
        let rowIndex = sender.tag
        guard let code =  contactsViewModel.responseModel?.data?[rowIndex].contactcode else {
            return
        }
        deleteScreenPopUp(desiredCode: code)
    }
    
    
    func updateUI(){
        print("Update UI is getting called")
        viewModel()
    }
    

    
    
    func allCatalogueView() {
        
        catalogueListingViewModel.requestModel.limit = "4"
        catalogueListingViewModel.requestModel.offset = "1"
        catalogueListingViewModel.requestModel.sort_folder = "DESC"
        catalogueListingViewModel.requestModel.type_of_list = "catalog_lists"
        
        
        startCustomLoader()
        //startCustomLoader(selfView: fileColView)
       
        
        catalogueListingViewModel.catalogueListing(request: catalogueListingViewModel.requestModel) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                
                // self.activityIndicator.stopAnimating()
                self.stopCustomLoader()
                
                switch result {
                case .goAhead:
                    if self.catalogueListingViewModel.responseModel?.data?.isEmpty == true {
                        self.fileColView.isHidden = true
                        self.emptyView.isHidden = false
                    } else {
                        self.fileColView.isHidden = false
                        self.emptyView.isHidden = true
                        
                        guard let value = self.catalogueListingViewModel.responseModel?.data else {
                            return
                        }
                        
                        self.tempMemory = value
                        self.isSkeletonVisible = false 
                        self.fileColView.reloadData()
                        //self.stopSkeleton()
                    }
                    
                case .heyStop:
                    print("Error")
                }
            }
        }
    }

    

    
    func viewModel() {
       // contactsTblView.addSubview(startCustomLoader())
       // startCustomLoader(selfView: contactsTblView)
        contactsViewModel.requestModel.offSet = "1"
        contactsViewModel.allContactList(request: contactsViewModel.requestModel) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                self.stopCustomLoader()
                //self.stopCustomLoader(selfView: self.contactsTblView)
                switch result {
                case .goAhead:
                    print("YO ✌🏽")
                    
                    let isEmpty = self.contactsViewModel.responseModel?.data?.isEmpty ?? true
                    self.contactsTblView.isHidden = isEmpty
                    self.emptyViewForContacts.isHidden = !isEmpty
                    
                    if isEmpty {
                        self.heightsOfContactsiTblView.constant = 150
                    } else {
                        let rowCount = self.contactsViewModel.responseModel?.data?.count ?? 1
                        self.heightsOfContactsiTblView.constant = CGFloat(70 * rowCount)
                    }
                    
                    self.contentViewHeight.constant = 1454 + self.heightsOfContactsiTblView.constant + 30
                    self.contactsTblView.reloadData()
                    
                case .heyStop:
                    print("Error")
                    // You might want to show an alert or error view here
                }
            }
        }
    }

    
    func showErrorPopup(message: String) {
        let errorPopup = GlobalPopUpVC(nibName: "GlobalPopUpVC", bundle: nil)
        errorPopup.modalPresentationStyle = .overCurrentContext
        errorPopup.modalTransitionStyle = .crossDissolve
        errorPopup.msgViewVar = message
        self.present(errorPopup, animated: true)
    }
    
    func deleteCatalogGlobalPopUp() {
        let errorPopup = DeleteCatalogueGlobalPopUp(nibName: "DeleteCatalogueGlobalPopUp", bundle: nil)
        errorPopup.modalPresentationStyle = .overCurrentContext
        errorPopup.modalTransitionStyle = .crossDissolve
        errorPopup.delegate = self
        
        
        self.present(errorPopup, animated: true)
        
        
    }
    
    
    @objc func deleteCatalogueBtnAction(_ sender: UIButton) {
        
        indexNo = sender.tag
        
        //deleteCatalogGlobalPopUp()
        self.deleteCatalogPopUp()
        
        
        print( "All Shared Information", self.catalogueListingViewModel.responseModel?.data?[indexNo].sharedcatalog)
        
        
    }//button action
    
    
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
    
    
    
    
    @IBAction func sharedCatalogueViewAll(_ sender: Any) {
        
        self.navigationController?.pushViewController(NewSharedCatalogueVC(), animated: true)
        
    }
    
    
    @objc func addNewContact(){
        // print("Tapped floating btn")
        navigationController?.pushViewController(AddContactViewController(), animated: true)
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
