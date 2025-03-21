//
//  ProfileViewController.swift
//  Emotipics
//
//  Created by Onqanet on 21/03/25.
//

import UIKit

class ProfileViewController: UIViewController {

    
    
    @IBOutlet weak var sideMenuTableView: UITableView!
    
    
    
    var contentsTitle = ["Home", "My Account", "Catalogue", "Contact List", "Groups", "About Us", "Terms & Conditions", "Support", "Logout"]
    
    var respectiveImg = ["Home","MyAccount", "Catalogue", "ContactList", "Group", "About Us", "Terms", "Support", "Logout"]
    
    
    
    
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var userEmail: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.sideMenuTableView.delegate = self
        self.sideMenuTableView.dataSource = self
        self.sideMenuTableView.backgroundColor = .white
        self.sideMenuTableView.separatorStyle = .singleLine
        
        self.sideMenuTableView.register(UINib(nibName: "SideMenuCell", bundle: nil), forCellReuseIdentifier: "SideBarCell")
        
        print("Screen Height: \(UIScreen.main.bounds.height)")
        
        let screenHeight = UIScreen.main.bounds.height
        
        //self.sideMenuTableView.isScrollEnabled = screenHeight < 750
        
        
        userName.font = UIFont(name: textInputStyle.poppinsMedium.rawValue, size: 18)
        userEmail.font = UIFont(name: textInputStyle.poppinsRegular.rawValue, size: 15)

    }
}

extension ProfileViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SideBarCell", for: indexPath) as? SideMenuCell else { fatalError("xib doesn't exist") }
        //cell.textLabel?.text = "The Number of the Cell\(indexPath.row)"
        cell.myTitleLbl.text = contentsTitle[indexPath.row]
        cell.imgViewTitle.image = UIImage(named: respectiveImg[indexPath.row])?.withRenderingMode(.alwaysTemplate)
        cell.imgViewTitle.tintColor = .black
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
