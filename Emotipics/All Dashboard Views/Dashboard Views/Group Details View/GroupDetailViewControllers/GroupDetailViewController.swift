//
//  GroupDetailViewController.swift
//  Emotipics
//
//  Created by Onqanet on 18/03/25.
//

import UIKit

class GroupDetailViewController: UIViewController {

    
    
    
    @IBOutlet weak var groupIconImgView: UIImageView!
    
    
    
    @IBOutlet weak var scrollViewHeight: NSLayoutConstraint!
    
    
    @IBOutlet weak var tblViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var detailTblView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        detailTblView.dataSource = self
        detailTblView.delegate = self
        detailTblView.register(UINib(nibName: "GroupDetailViewCell", bundle: nil), forCellReuseIdentifier: "DetailChat")
        
        tblViewHeight.constant = 10*300
        scrollViewHeight.constant = tblViewHeight.constant + 50
        
    }
}



extension GroupDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailChat", for: indexPath) as! GroupDetailViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}






