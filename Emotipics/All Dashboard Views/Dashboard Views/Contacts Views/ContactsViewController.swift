//
//  ContactsViewController.swift
//  Emotipics
//
//  Created by Onqanet on 11/03/25.
//

import UIKit

class ContactsViewController: UIViewController, UpdateUI {
    
    
    
    @IBOutlet weak var tableViewBackGround: UIView!{
        didSet{
            tableViewBackGround.layer.cornerRadius = 25
            tableViewBackGround.clipsToBounds = true    
        }
    }
    
    
    @IBOutlet weak var contactsTblView: UITableView!
    
    
    
    
    private var floatingBtn: FloatingBtn = {
        let btn = FloatingBtn()
        btn.translatesAutoresizingMaskIntoConstraints = false
      //  btn.setTarget(ContactsViewController.self, action: #selector(handleFloatingBtnTap), for: .touchUpInside)
        return btn
    }()
    
    var allContactsViewModel: AllContactsViewModel = AllContactsViewModel()
    
    //var notificationView:Bool = false
    
    let emptyViewForContacts = EmptyCollView()
    
    
    var contactsData: [Datam] = []
    
    private let footerActivityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.color = .gray
        indicator.hidesWhenStopped = true
        return indicator
    }()

    
//    var activityIndicator: UIActivityIndicatorView = {
//        let indicator = UIActivityIndicatorView(style: .large)
//        indicator.color = .systemOrange
//        indicator.hidesWhenStopped = true
//        return indicator
//    }()
    

    @IBOutlet weak var contentView: UIView!
    
    private var loaderView: ImageLoaderView?
    
    var isPaginating = false
    var currentPage = 1


   

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemRed
        contactsTblView.delegate = self
        contactsTblView.dataSource = self
       // contactsTblView.register(UITableViewCell.self, forCellReuseIdentifier: "Example")
        
        
        let tableHeaderView = ContactsView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 5))
             //   self.tableView.tableHeaderView = tableHeaderView
        self.contactsTblView.tableHeaderView = tableHeaderView
        
        contactsTblView.register(UINib(nibName: "EntryTableViewCell", bundle: nil), forCellReuseIdentifier: "TableCell")
        
    
        
        contactsTblView.tableFooterView = footerActivityIndicator
        
        footerActivityIndicator.frame = CGRect(x: 0, y: 0, width: contactsTblView.bounds.width, height: 50)

        
        addPlusIcon()
     //   setupActivityIndicator()
    
        contactsAllViewModel()
        
        
        
        setupEmptyContactView()
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        //self.tabBarController?.editButtonItem.isHidden = true
        if let tabBarController = self.tabBarController {
                for subview in tabBarController.view.subviews {
                    if let button = subview as? UIButton,
                       button.backgroundImage(for: .normal) == UIImage(named: "PlusIcon") {
                        button.isHidden = true
                    }
                }
            }
        
        
        contactsAllViewModel()
        
    }
    
    func contactsAllViewModel(){
        //activityIndicator.startAnimating()
        startCustomLoader()
        
        allContactsViewModel.requestModel.offSet = "1"
        
        allContactsViewModel.allContactList(request: allContactsViewModel.requestModel) { result in
            DispatchQueue.main.async {
                //self.activityIndicator.stopAnimating()
                self.stopCustomLoader()
                switch result {
                case .goAhead:
                    print("Success 👍🏽")
                    //table View Reload Data
                    if let contactsViewCount = self.allContactsViewModel.responseModel?.data {
                        self.contactsData = contactsViewCount
                        if contactsViewCount.count == 0 {
                            self.emptyViewForContacts.isHidden = false
                        } else {
                            self.emptyViewForContacts.isHidden = true
                        }
                    } else {
                        
                    }
                    DispatchQueue.main.async {
                        self.contactsTblView.reloadData()
                    }
                case .heyStop:
                    print("Error")
                }
                
                
            }
            
            
        }
    }
    
    
    
    

    
    
    func addPlusIcon(){
       // floatingBtn.addSubview(Flo)
        view.addSubview(floatingBtn)
        
        
        floatingBtn.setTarget(self, action: #selector(handleFloatingBtnTap), for: .touchUpInside)
        
        NSLayoutConstraint.activate([
            floatingBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -90),
            floatingBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            floatingBtn.heightAnchor.constraint(equalToConstant: 60),
            floatingBtn.widthAnchor.constraint(equalToConstant: 60)
        ])
        
    }
    
    
    func updateUI(){
        print("Update UI is getting called")
        contactsAllViewModel()
    }
    
    
    func setupEmptyContactView(){
        
        emptyViewForContacts.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(emptyViewForContacts)
        
        emptyViewForContacts.noCatLbl.text = "No Contacts!"
        emptyViewForContacts.addSomeCat.text = "Add Some Contact to Share"
        
        emptyViewForContacts.addBtn.setTitle("Add New Contact", for: .normal)
        
        emptyViewForContacts.addBtn.addTarget(self, action: #selector(handleFloatingBtnTap), for: .touchUpInside)
        
        // Set constraints
        NSLayoutConstraint.activate([
            emptyViewForContacts.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 100),
            emptyViewForContacts.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            emptyViewForContacts.widthAnchor.constraint(equalTo: view.widthAnchor),
            emptyViewForContacts.heightAnchor.constraint(equalToConstant: 250) // adjust as needed
        ])
        
        // Call method to setup inner views
        emptyViewForContacts.settingUpConstraints()
    }
    
    
    
    @IBAction func backToPrev(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @objc func handleFloatingBtnTap() {
        print("Tapped floating btn")
        navigationController?.pushViewController(AddContactViewController(), animated: true)
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
        guard let code =  allContactsViewModel.responseModel?.data?[rowIndex].contactcode else {
            return
        }
        deleteScreenPopUp(desiredCode: code)
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


extension ContactsViewController: UITableViewDelegate , UITableViewDataSource, UIScrollViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return allContactsViewModel.responseModel?.data?.count ?? 0
        return contactsData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

            let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! EntryTableViewCell
        

        
        cell.sarahLbl.text = contactsData[indexPath.row].contactdetails?.name
        cell.associatedEmailTxtFld.text = contactsData[indexPath.row].contactdetails?.email
        
        cell.moreActionBtn.tag = indexPath.row
        cell.moreActionBtn.addTarget(self, action: #selector(popUpFromBottom(_:)), for: .touchUpInside)
            return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       
            return 80
      
    }
    

    func numberOfSections(in tableView: UITableView) -> Int {
            return 1 // Defines one section
        }
        
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
           let header = UIView()
           //header.titleLabel.text = "Contacts List" // Set the title text
           return header
       }

       // Set header height
       func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
           return 50
           
       }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        let position = scrollView.contentOffset.y
//        if position > (contactsTblView.contentSize.height - 3 - scrollView.frame.size.height) {
//
//            guard !isPaginating else { return }
//                    isPaginating = true
//                    currentPage += 1
//                    fetchPaginatedContacts(page: currentPage)
//        }
        
        
        let position = scrollView.contentOffset.y
            let contentHeight = contactsTblView.contentSize.height
            let frameHeight = scrollView.frame.size.height

            if position > (contentHeight - frameHeight - 20), !isPaginating {
                paginateContacts()
            }
    }
    
    func paginateContacts() {
        isPaginating = true
        footerActivityIndicator.startAnimating()
        currentPage += 1
        allContactsViewModel.requestModel.offSet = "\(currentPage)"

        allContactsViewModel.allContactList(request: allContactsViewModel.requestModel) { result in
            DispatchQueue.main.async {
                self.footerActivityIndicator.stopAnimating()
                self.isPaginating = false

                switch result {
                case .goAhead:
                    print("Contacts View Count is")
                    
                    if let contactsViewCount = self.allContactsViewModel.responseModel?.data {
                        
                        if contactsViewCount.count == 0 {
                            
                        } else {
                            self.contactsData.append(contentsOf: contactsViewCount)
                        }
                    }
                    else {
                        
                    }
                    
                    
                    self.contactsTblView.reloadData()
                case .heyStop:
                    print("Pagination failed or no more data")
                }
            }
        }
    }

}




