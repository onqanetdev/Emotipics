//
//  ContactsViewController.swift
//  Emotipics
//
//  Created by Onqanet on 11/03/25.
//

import UIKit

class ContactsViewController: UIViewController {
    
    
    
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
    
    
    
    var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .systemOrange
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
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
        
    
        addPlusIcon()
        //GetAllContactList.getAllContacts(offset: "1")
        setupActivityIndicator()
        
        activityIndicator.startAnimating()
        allContactsViewModel.allContactList { result in
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                
                switch result {
                case .goAhead:
                    print("Success 👍🏽")
                    //table View Reload Data
                    DispatchQueue.main.async {
                        self.contactsTblView.reloadData()
                    }
                case .heyStop:
                    print("Error")
                }
                
                
            }
            
            
        }
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
    
    
    
    @IBAction func backToPrev(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @objc func handleFloatingBtnTap() {
        print("Tapped floating btn")
        navigationController?.pushViewController(AddContactViewController(), animated: true)
    }
    
    
}


extension ContactsViewController: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allContactsViewModel.responseModel?.data?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

            let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! EntryTableViewCell
        cell.sarahLbl.text = allContactsViewModel.responseModel?.data?[indexPath.row].contactdetails?.name
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
}










