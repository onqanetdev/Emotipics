//
//  GroupListViewController.swift
//  Emotipics
//
//  Created by Onqanet on 17/03/25.
//

import UIKit

class GroupListViewController: UIViewController {

    
    
    @IBOutlet weak var groupHeadingLbl: UILabel!{
        didSet {
            groupHeadingLbl.font = UIFont(name: textInputStyle.latoBold.rawValue, size: 25)
        }
    }
    
    
    @IBOutlet weak var curvedView: UIView! {
        didSet {
            curvedView.layer.cornerRadius = 35
            curvedView.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var tblViewForGroups: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tblViewForGroups.dataSource = self
        tblViewForGroups.delegate = self
        tblViewForGroups.register(UINib(nibName: "GroupTableViewCell", bundle: nil), forCellReuseIdentifier: "Group")
        
        
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
    
}



extension GroupListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Group", for: indexPath) as! GroupTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
        
    }
}
