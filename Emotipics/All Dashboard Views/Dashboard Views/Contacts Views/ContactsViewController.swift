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
    
    
    
    
    private var floatingBtn: UIView = {
        let btn = FloatingBtn()
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    
    
    //var notificationView:Bool = false
    
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
        
        
    }
    
    
    func addPlusIcon(){
       // floatingBtn.addSubview(Flo)
        view.addSubview(floatingBtn)
        
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
    
}


extension ContactsViewController: UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

            let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! EntryTableViewCell
           
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
