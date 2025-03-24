//
//  MyAccountDetailsVC.swift
//  Emotipics
//
//  Created by Onqanet on 24/03/25.
//

import UIKit

class MyAccountDetailsVC: UIViewController {
    
    
    
    @IBOutlet weak var backgroundView: UIView! {
        didSet {
            backgroundView.layer.cornerRadius = 30
            backgroundView.clipsToBounds = true
        }
    }
    
    
    
    @IBOutlet weak var userTitleLbl: UILabel!
    
    
    @IBOutlet weak var userEmailLbl: UILabel!
    
    
    
    @IBOutlet weak var myAccountLbl: UILabel!
    

    //MARK: Table View
    
    @IBOutlet weak var myAccountDetails: UITableView!
    
    
    
    let contents = ["Account Details", "Catalogue", "Conatact List", "Groups", "Logout"]
    
    let contentsIcon = ["MyAccount", "Catalogue", "ContactList", "Group", "Logout"]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        myAccountDetails.dataSource = self
        myAccountDetails.delegate = self
        
        myAccountDetails.register(UINib(nibName: "SideMenuCell", bundle: nil), forCellReuseIdentifier: "SideBarCell")
        
        userTitleLbl.font = UIFont(name: textInputStyle.latoBold.rawValue, size: 22)
        userEmailLbl.font = UIFont(name: textInputStyle.poppinsRegular.rawValue, size: 15)
        myAccountLbl.font = UIFont(name: textInputStyle.poppinsRegular.rawValue, size: 19)
    }
    
    
    
    
    @IBAction func backToPrevious(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
    }
    
    
}


extension MyAccountDetailsVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SideBarCell", for: indexPath) as! SideMenuCell
        cell.myTitleLbl.text = contents[indexPath.row]
        cell.moreBtn.isHidden = false        //cell.
       // cell.textLabel?.text = contents[indexPath.row]
        cell.imgViewTitle.image = UIImage(named: contentsIcon[indexPath.row])?.withRenderingMode(.alwaysTemplate)
        cell.imgViewTitle.tintColor = .black
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
}
