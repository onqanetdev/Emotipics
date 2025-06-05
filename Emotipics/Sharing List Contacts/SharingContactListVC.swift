//
//  SharingContactListVC.swift
//  Emotipics
//
//  Created by Onqanet on 11/04/25.
//

import UIKit

class SharingContactListVC: UIViewController {
    
    
    @IBOutlet weak var roundedView: UIView!{
        didSet{
            roundedView.layer.cornerRadius = 30
            roundedView.clipsToBounds = true
        }
    }
    
    
    
    
    @IBOutlet weak var submitBtn: UIButton!{
        didSet{
            submitBtn.layer.cornerRadius = 15
            submitBtn.clipsToBounds = true
        }
    }
    
    
    
    @IBOutlet weak var catalogueNameLbl: UILabel!{
        didSet{
            catalogueNameLbl.isHidden = true
        }
    }
    
    
    
    
    @IBOutlet weak var contactListTblView: UITableView!
    
    
    
    var conatactViewModel:AllContactsViewModel = AllContactsViewModel()
    var data:[Datam] = []
    var catalogData:[DataM] = []
    
    var shareIndex = 0
    var selectedContacts:[String] = []
    
    
    
    var  selectedContactsForShare:[String] = []
    
    
    var catalogueUserAddViewModel:CatalogueUserAddViewModel = CatalogueUserAddViewModel()
    
    
    private var loaderView: ImageLoaderView?
    
    var shareImgViewModel: ImageShareViewModel = ImageShareViewModel()
    
    var catalogueName = ""
    
    var shareImage:Bool = false
    
    var imageShareViewModel: ImageShareViewModel = ImageShareViewModel()
    
    
    var imgId: Int = 0
    var userCode: String = ""
    
    
    //For All Groups
    var contactListForGr: Bool = false
    var groupData:[GroupData] = []
    var groupAddUserViewModel:GroupAddUserViewModel = GroupAddUserViewModel()
    var groupCode: String = ""
    
    
    //MARK: All for birthday wishes
    var isBirthday:Bool = false
    // var selectedContactsForBirth:[String] = []
    var selectedContactsForBirth: [SelectedBirthDate] = []
    var birthdayMSG: String = ""
    var addBirthdayViewModel:AddBirthdayViewModel = AddBirthdayViewModel()
    
    var previouslySelectedBirthdayIndex: Int?
    
    
    var imageURL = ""
    
    
    
    var isPaginating = false
    var currentPage = 1
    
    
    
    private let footerActivityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.color = .gray
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        contactListTblView.dataSource = self
        contactListTblView.delegate = self
        
        contactListTblView.register(UINib(nibName: "SharingContactListTVC", bundle: nil), forCellReuseIdentifier: "SharingListTVC" )
        
        catalogueNameLbl.text = catalogueName
        // setupActivityIndicator()
        loadAllContacts()
        selectedContacts = []
        
        contactListTblView.tableFooterView = footerActivityIndicator
        
        footerActivityIndicator.frame = CGRect(x: 0, y: 0, width: contactListTblView.bounds.width, height: 50)

        
        //        print("The Catalog data is ", catalogData[shareIndex].)
    }
    
    
    
    
    @IBAction func btnAction(_ sender: Any) {
        
        if contactListForGr {
            
            addContactsToGrp()
            
        } else {
            
            //Group Adding true or false
            
            if shareImage {
                let modifiedStringForShare = selectedContactsForShare.joined(separator: ",")
                print("Modified String for share Image: \(modifiedStringForShare)")
                
                
                imageShareViewModel.requestModel.image_id = imgId
                imageShareViewModel.requestModel.user_code = modifiedStringForShare
                
                imageShareViewModel.imageShareViewModel(request:imageShareViewModel.requestModel, viewController: self ) { result in
                    DispatchQueue.main.async {
                        //self.activityIndicator.stopAnimating()
                        
                        switch result {
                        case .goAhead:
                            print("Success from SharingContactListVC")
                            
                            
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
            
            else if isBirthday {
                //                let modfiedString = selectedContactsForBirth.joined(separator: ",")
                //                print("The Modified String-->", modfiedString)
                
                let modifiedString = selectedContactsForBirth.map { $0.selectedContactCode }.joined(separator: ",")
                print("The Modified String-->", modifiedString)
                
                let birthdayPopUpView = BirthdayPopUpView(nibName: "BirthdayPopUpView", bundle: nil)
                birthdayPopUpView.modalPresentationStyle = .overCurrentContext
                birthdayPopUpView.modalTransitionStyle = .crossDissolve
                
                
                birthdayPopUpView.onCompletion = { birthDayMsg in
                    self.birthdayMSG = birthDayMsg
                    print("Received Birthday Message: \(birthDayMsg)")
                    
                    // Handle message here
                    
                    //                    self.addBirthdayFunction(msgString: self.birthdayMSG, userCode: modifiedString, immgURL: self.imageURL, notifyDate: "2007-05-23")
                    
                    if let notifyDate = self.selectedContactsForBirth.first?.dateOfBirth {
                        print("The notify date is ", notifyDate)
                        self.addBirthdayFunction(
                            msgString: self.birthdayMSG,
                            userCode: modifiedString,
                            immgURL: self.imageURL,
                            notifyDate: notifyDate
                        )
                    }
                    
                    
                }
                
                
                print("Desired Image URL--->", imageURL)
                
                self.present(birthdayPopUpView, animated: true, completion: nil)
                
            }
            
            
            else
            {
                print("Submitted List Will Be", catalogData[shareIndex].catalog_code )
                // print("Selcted Contacts will be", selectedContacts)
                let modifiedString = selectedContacts.joined(separator: ",")
                print("Modified String: \(modifiedString)")
                //activityIndicator.startAnimating()
                if let catalogCode = catalogData[shareIndex].catalog_code{
                    
                    
                    catalogueUserAddViewModel.requestModel.catalogcode = catalogCode
                    catalogueUserAddViewModel.requestModel.contact_code = modifiedString
                    
                    catalogueUserAddViewModel.catalogueUserAddViewModel(request:catalogueUserAddViewModel.requestModel, viewController: self ) { result in
                        DispatchQueue.main.async {
                            //self.activityIndicator.stopAnimating()
                            
                            switch result {
                            case .goAhead:
                                print("Success from SharingContactListVC")
                                //table View Reload Data
                                DispatchQueue.main.async {
                                    //self.contactsTblView.reloadData()
                                    // self.dismiss(animated: true )
                                    //self.deleteDelegate?.updateUI()
                                }
                            case .heyStop:
                                print("Error")
                            }
                            
                            
                        }
                    }
                    
                    
                } else {
                    AlertView.showAlert("Warning!", message: "Catalog Code is not valid", okTitle: "OK")
                }
            }//Is shareImage false
            //Group Adding true or false
        }
        
    }
    
    
    
    @IBAction func backBtnAction(_ sender: Any) {
        
        self.dismiss(animated: true)
        
    }
    
    func loadAllContacts(){
        
        // activityIndicator.startAnimating()
        startCustomLoader()
        conatactViewModel.requestModel.offSet = "1"
        conatactViewModel.allContactList(request: conatactViewModel.requestModel) { result in
            DispatchQueue.main.async {
                //   self.activityIndicator.stopAnimating()
                self.stopCustomLoader()
                switch result {
                case .goAhead:
                    
                    DispatchQueue.main.async {
                        
                        if let latestData = self.conatactViewModel.responseModel?.data {
                            self.data = latestData
                            if self.shareImage {
                                self.catalogueNameLbl.text = self.catalogueName
                            } else {
                                if self.contactListForGr {
                                    
                                    
                                    self.catalogueNameLbl.text = self.groupData[self.shareIndex].groupname
                                    
                                    
                                }
                                else if self.isBirthday {
                                    
                                    self.catalogueNameLbl.text = ""
                                    print("🐬🐬🐬🐬🐬🐬🐬🐬🐬🐬🐬🐬🐬🐬🐬🐬🐬🐬🐬🐬🐬🐬🐬🐬")
                                    print("The Data is--->", self.data.count)
                                    
                                }
                                else
                                {
                                    
                                    self.catalogueNameLbl.text = self.catalogData[self.shareIndex].catalog_name
                                    
                                }
                                
                            }
                            
                        } else {
                            AlertView.showAlert("Alert!", message: "There is no data", okTitle: "OK")
                        }
                        self.contactListTblView.reloadData()
                        
                        
                        
                    }
                case .heyStop:
                    print("Error")
                }
                
                
            }
            
            
        }
    }
    
    
    func addContactsToGrp() {
        let modifiedStringForShare = selectedContacts.joined(separator: ",")
        print("Modified String for share Image: \(modifiedStringForShare)")
        
        
        groupAddUserViewModel.requestModel.groupCode = groupCode
        groupAddUserViewModel.requestModel.contactCode = modifiedStringForShare
        
        groupAddUserViewModel.groupAddUserViewModel(request:groupAddUserViewModel.requestModel) { result in
            DispatchQueue.main.async {
                //self.activityIndicator.stopAnimating()
                
                switch result {
                case .goAhead:
                    print("Success from SharingContactListVC for adding contact✅")
                    
                    
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
    
    
    func addBirthdayFunction(msgString: String, userCode: String, immgURL: String, notifyDate: String) {
        print("MSGString is ",msgString)
        print("userCode is ", userCode)
        print("immgURL is ", immgURL)
        print("notify date is ", notifyDate)
        
        addBirthdayViewModel.requestModel.message = msgString
        addBirthdayViewModel.requestModel.user_code = userCode
        addBirthdayViewModel.requestModel.image_url = immgURL
        addBirthdayViewModel.requestModel.notifydate = notifyDate
        
        startCustomLoader()
        
        addBirthdayViewModel.addBirthdayViewModel(request: addBirthdayViewModel.requestModel) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                
                self.stopCustomLoader()
                switch result {
                case .goAhead:
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
    
    
    @objc func checkUncheck(_ sender: UIButton){
        if sender.currentBackgroundImage == UIImage(systemName: "square"){
            sender.setBackgroundImage(UIImage(systemName: "checkmark.square"), for: .normal)
            
            
            if shareImage {
                
                if let userCode = data[sender.tag].contactdetails?.code {
                    selectedContactsForShare.append(userCode)
                    print("✅✅✅✅✅✅Added: \(userCode)")
                }
                
            }
            else if isBirthday {
                
                // Allow only one selection
                if let previousIndex = previouslySelectedBirthdayIndex,
                   let previousCell = self.view.viewWithTag(previousIndex) as? UIButton {
                    // Uncheck previously selected button
                    previousCell.setBackgroundImage(UIImage(systemName: "square"), for: .normal)
                }
                previouslySelectedBirthdayIndex = sender.tag
                selectedContactsForBirth.removeAll()
                
                
                
                if let contactCode = data[sender.tag].contactdetails?.code,
                   let contactDob = data[sender.tag].contactdetails?.dob{
                    let selectedBirthDate = SelectedBirthDate(selectedContactCode: contactCode, dateOfBirth: contactDob)
                    selectedContactsForBirth.append(selectedBirthDate)
                    
                    print("✅ Selected Contacts For Birth Day--->>>>", selectedContactsForBirth)
                }
            }
            
            else
            {
                if let contactCode = data[sender.tag].contactcode {
                    selectedContacts.append(contactCode)
                    print("✅ Added: \(contactCode)")
                }
            }
            
        } else {
            sender.setBackgroundImage(UIImage(systemName: "square"), for: .normal)
            
            if shareImage {
                
                if let userCode = data[sender.tag].contactdetails?.code,
                   let index = selectedContactsForShare.firstIndex(of: userCode) {
                    selectedContactsForShare.remove(at: index)
                    print("❌❌❌❌❌❌Removed: \(userCode)")
                }
                
                
            }
            
            else if isBirthday {
                if let userCode = data[sender.tag].contactdetails?.code,
                   let index = selectedContactsForBirth.firstIndex(where: { $0.selectedContactCode == userCode }) {
                    selectedContactsForBirth.remove(at: index)
                    print("❌❌Removed: \(userCode)")
                }
            }
            
            
            
            else {
                
                if let contactCode = data[sender.tag].contactcode,
                   let index = selectedContacts.firstIndex(of: contactCode) {
                    selectedContacts.remove(at: index)
                    print("❌ Removed: \(contactCode)")
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

extension SharingContactListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return 10
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SharingListTVC", for: indexPath) as! SharingContactListTVC
        cell.selectionStyle = .none
        //cell.textLabel?.text = "Custom"
        cell.checkboxBtn.tag = indexPath.row
        cell.contactLbl.text = data[indexPath.row].contactdetails?.name
        cell.checkboxBtn.addTarget(self, action: #selector(checkUncheck(_ :)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print("All My Selected Contacts Are ", selectedContacts)
        
        print("Selected Date of Birth for the row-->", data[indexPath.row].contactdetails?.dob)
    }
}




extension SharingContactListVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        let position = scrollView.contentOffset.y
            let contentHeight = contactListTblView.contentSize.height
            let frameHeight = scrollView.frame.size.height

            if position > (contentHeight - frameHeight - 20), !isPaginating {
                paginateContacts()
            }
        
        
    }
    
    
    func paginateContacts() {
        isPaginating = true
        footerActivityIndicator.startAnimating()
        currentPage += 1
        conatactViewModel.requestModel.offSet = "\(currentPage)"

        conatactViewModel.allContactList(request: conatactViewModel.requestModel) { result in
            DispatchQueue.main.async {
                self.footerActivityIndicator.stopAnimating()
                self.isPaginating = false

                switch result {
                case .goAhead:
                    print("Contacts View Count is")
                    
                    if let contactsViewCount = self.conatactViewModel.responseModel?.data {
                        
                        if contactsViewCount.count == 0 {
                            
                        } else {
                            self.data.append(contentsOf: contactsViewCount)
                        }
                    }
                    else {
                        
                    }
                    
                    
                    self.contactListTblView.reloadData()
                case .heyStop:
                    print("Pagination failed or no more data")
                }
            }
        }
    }
}
