//
//  EntryViewController.swift
//  Emotipics
//
//  Created by Onqanet on 06/03/25.
//

import UIKit
import Charts


class EntryViewController: UIViewController , UpdateUI{
    
    
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
    
    
    @IBOutlet weak var fileColView: UICollectionView!
    
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
    
    
    
    
    @IBOutlet weak var contactsTblView: UITableView!
    
    
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
    
    
    var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .systemOrange
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        // Setting Ups The font
        
        userExists()
        
        settingUpFonts()

        
        
        rotateBtn.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        fileColView.delegate = self
        fileColView.dataSource = self
        //fileColView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        fileColView.register(UINib(nibName: "EntryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        
        
        
        
        // Table Views for contact Listing
        contactsTblView.dataSource = self
        contactsTblView.delegate = self
       // contactsTblView.register(UITableViewCell.self, forCellReuseIdentifier: "TableCell")
        contactsTblView.register(UINib(nibName: "EntryTableViewCell", bundle: nil), forCellReuseIdentifier: "TableCell")
       // contactsTblView.isHidden = true
        
        //Manipulating contentViewHeight
        //contentViewHeight.constant = 850
        
        contentViewHeight.constant = 835
        
        //heightsOfContactsiTblView.constant = 100
        heightsOfContactsiTblView.constant = 70
        contentViewHeight.constant += heightsOfContactsiTblView.constant
        pertentageLbl.translatesAutoresizingMaskIntoConstraints = false
        setupCircularView()
        setupPecentageLbl()
    
        sideMenuManager.setup(in: self)
        setupActivityIndicator()
        
        activityIndicator.startAnimating() 
        
        contactsViewModel.allContactList { result in
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                
                switch result {
                case .goAhead:
                    print("YO ✌🏽")
                    //table View Reload Data
                    DispatchQueue.main.async { [self] in
                        heightsOfContactsiTblView.constant = CGFloat(70 * (self.contactsViewModel.responseModel?.data?.count ?? 1))
                        contentViewHeight.constant = contentViewHeight.constant + heightsOfContactsiTblView.constant
                        self.contactsTblView.reloadData()
                        
                    }
                case .heyStop:
                    print("Error")
                }
                
                
            }
            
            
        }
//        DispatchQueue.main.async {
//            self.contactsTblView.reloadData()
//        }
        
        allCatalogueView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = false
        viewModel()
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
    
    

    
    @IBAction func allCatalogueAction(_ sender: Any) {
        
//        CatalogueListingApiCaller.catalogueListingCaller(limit: "4", offset: "1", sortfolder: "DESC", typeOfList: "catalog_lists")
        navigationController?.pushViewController(CatalogueViewController(), animated: true)
        //print("The Navigation is not working")
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
        //errorPopup.msgViewVar = message
        //errorPopup.delegate = self
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
        
        activityIndicator.startAnimating()
        
        catalogueListingViewModel.catalogueListing(request: catalogueListingViewModel.requestModel) { result in
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                
                switch result {
                case .goAhead:
                    print("Catalogue View Model from Catalogue View Controller")
                    //table View Reload Data
                    
                   if self.catalogueListingViewModel.responseModel?.data?.isEmpty == true{
                       self.fileColView.isHidden = true
                    }
                    
                    
                    DispatchQueue.main.async { [self] in
                        fileColView.reloadData()
                        
                   }
                case .heyStop:
                    print("Error")
                }
                
                
            }
            
            
        }
    }
    
    
    
    
    func viewModel(){
        activityIndicator.startAnimating()
        
        contactsViewModel.allContactList { result in
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                
                switch result {
                case .goAhead:
                    print("YO ✌🏽")
                    //table View Reload Data
                    
                    
                    if self.contactsViewModel.responseModel?.data?.isEmpty == true {
                        self.contactsTblView.isHidden = true
                    } else {
                        
                        
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
}
