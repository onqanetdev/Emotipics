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
    
    //MARK: current Plans Titles
    
    @IBOutlet weak var CurrentPlanView: UIView!{
        didSet{
            //1.Add corner radius
            CurrentPlanView.layer.cornerRadius = 20
            CurrentPlanView.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var getMoreLbl: UILabel!
    @IBOutlet weak var priceTagLbl: UILabel!
    @IBOutlet weak var viewPlansBtn: UIButton!{
        didSet{
            viewPlansBtn.layer.cornerRadius = 10
            viewPlansBtn.clipsToBounds = true
        }
    }
    
    
    @IBOutlet weak var blueCircle: UIView! {
        didSet {
            blueCircle.layer.cornerRadius = blueCircle.frame.size.width / 2
            blueCircle.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var lightBlueCircle: UIView! {
        didSet {
            lightBlueCircle.layer.cornerRadius = lightBlueCircle.frame.size.width / 2
            lightBlueCircle.clipsToBounds = true
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
    @IBOutlet weak var getHundredGbLbl: UILabel!
    
    
    @IBOutlet weak var myContactsLbl: UILabel!
    
    
    
    @IBOutlet weak var photosLbl: UILabel!
    
    @IBOutlet weak var videosLbl: UILabel!
    
    @IBOutlet weak var nineGbLbl: UILabel!
    
    @IBOutlet weak var sixGbLbl: UILabel!
    
    
    
    
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
    
    
    @IBOutlet weak var priceTagImg: UIImageView!
    
    
    @IBOutlet weak var backImgView: UIImageView! {
        didSet {
            backImgView.layer.cornerRadius = 30
            backImgView.clipsToBounds = true
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
    
    
//    var activityIndicator: UIActivityIndicatorView = {
//        let indicator = UIActivityIndicatorView(style: .large)
//        indicator.color = .systemOrange
//        indicator.hidesWhenStopped = true
//        return indicator
//    }()
//    
    
    let emptyView = EmptyCollView()
    let emptyViewForContacts = EmptyCollView()
    
    @IBOutlet weak var catalogueTitleView: UIView!
    
    
    @IBOutlet weak var contentView: UIView!
    
    
    @IBOutlet weak var myContactsHeaderView: UIView!
    
    
    var deleteCatalogueViewModel: DeleteCatalogViewModel = DeleteCatalogViewModel()
    
    
    var tempMemory:[DataM] = []
    
    
    
    var userName = ""
    
    private var loaderView: ImageLoaderView?
    
    
    
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
        
        
        
        
        // Table Views for contact Listing
        contactsTblView.dataSource = self
        contactsTblView.delegate = self
        
        contactsTblView.register(UINib(nibName: "EntryTableViewCell", bundle: nil), forCellReuseIdentifier: "TableCell")
        
        
        contentViewHeight.constant = 835
        
        
        heightsOfContactsiTblView.constant = 70
        contentViewHeight.constant += heightsOfContactsiTblView.constant
        pertentageLbl.translatesAutoresizingMaskIntoConstraints = false
        setupCircularView()
        setupPecentageLbl()
        
        sideMenuManager.setup(in: self)
       // setupActivityIndicator()
        
        allCatalogueView()
        
        setupEmptyView()
        
        viewModel()
        setupEmptyViewForContacts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = false
        viewModel()
        allCatalogueView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        viewModel()
        allCatalogueView()
    }
    
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
        getHundredGbLbl.font = UIFont(name: textInputStyle.latoBold.rawValue, size: 17)
        myContactsLbl.font = UIFont(name: textInputStyle.latoBold.rawValue, size: 17)
        //setting ups for fonts poppins-regular
        photosLbl.font = UIFont(name: textInputStyle.poppinsRegular.rawValue, size: 13)
        videosLbl.font = UIFont(name: textInputStyle.poppinsRegular.rawValue, size: 13)
        nineGbLbl.font = UIFont(name: textInputStyle.poppinsRegular.rawValue, size: 13)
        sixGbLbl.font = UIFont(name: textInputStyle.poppinsRegular.rawValue, size: 13)
        //settings ups for fonts poppins-medium
        
        priceTagLbl.font = UIFont(name: textInputStyle.poppinsMedium.rawValue, size: 13)
        viewPlansBtn.titleLabel?.font = UIFont(name: textInputStyle.poppinsMedium.rawValue, size: 14)
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
        
        
        navigationController?.pushViewController(CatalogueViewController(), animated: true)
        
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
        
        //activityIndicator.startAnimating()
        startCustomLoader()
        
        catalogueListingViewModel.catalogueListing(request: catalogueListingViewModel.requestModel) { result in
            DispatchQueue.main.async { [self] in
                // self.activityIndicator.stopAnimating()
                stopCustomLoader()
                switch result {
                case .goAhead:
                    // print("View Controller updated index", )
                    //table View Reload Data
                    
                    //                    print("Catalogue Listing View model Shared Contact data", self.catalogueListingViewModel.responseModel?.data?[indexNo].sharedcatalog?.count as Any)
                    
                    
                    
                    if self.catalogueListingViewModel.responseModel?.data?.isEmpty == true{
                        self.fileColView.isHidden = true
                        self.emptyView.isHidden = false
                    } else {
                        
                        self.fileColView.isHidden = false
                        self.emptyView.isHidden = true
                        
                        guard let value = self.catalogueListingViewModel.responseModel?.data else {
                            return
                        }
                        
                        self.tempMemory = value
                        
                        
                        
                        
                        DispatchQueue.main.async { [self] in
                            fileColView.reloadData()
                            
                        }
                    }
                    
                case .heyStop:
                    print("Error")
                }
                
                
            }
            
            
        }
    }
    
    
    
    
    func viewModel(){
        //activityIndicator.startAnimating()
        startCustomLoader()
        
        contactsViewModel.allContactList { result in
            DispatchQueue.main.async { [self] in
                //self.activityIndicator.stopAnimating()
                stopCustomLoader()
                switch result {
                case .goAhead:
                    print("YO ✌🏽")
                    //table View Reload Data
                    
                    
                    if self.contactsViewModel.responseModel?.data?.isEmpty == true {
                        self.contactsTblView.isHidden = true
                        self.emptyViewForContacts.isHidden = false
                        
                        self.heightsOfContactsiTblView.constant = 150
                        contentViewHeight.constant = 835 + heightsOfContactsiTblView.constant
                        
                    } else {
                        self.contactsTblView.isHidden = false
                        self.emptyViewForContacts.isHidden = true
                        
                        DispatchQueue.main.async { [self] in
                            heightsOfContactsiTblView.constant = CGFloat(70 * (self.contactsViewModel.responseModel?.data?.count ?? 1))
                            contentViewHeight.constant = 835 + heightsOfContactsiTblView.constant
                            self.contactsTblView.reloadData()
                            
                        }
                    }
                case .heyStop:
                    print("Error")
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
