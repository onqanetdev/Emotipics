//
//  EntryViewController+TableViewControllers.swift
//  Emotipics
//
//  Created by Onqanet on 06/03/25.
//

import Foundation
import UIKit



extension EntryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactsViewModel.responseModel?.data?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableCell", for: indexPath) as! EntryTableViewCell
        //cell.textLabel?.text = "Cell No.: \(indexPath.row)"
        //cell.backgroundColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
        cell.sarahLbl.text = contactsViewModel.responseModel?.data?[indexPath.row].contactdetails?.name
        cell.layer.cornerRadius = 10
        cell.moreActionBtn.tag = indexPath.row
        cell.moreActionBtn.addTarget(self, action: #selector(popUpFromBottom(_:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("Current height of the view is ", heightsOfContactsiTblView.constant)
//        let height:CGFloat = 70
//        heightsOfContactsiTblView.constant += height
//        contentViewHeight.constant = contentViewHeight.constant + height // this 100 is the height of the cell
//        tableView.reloadData()
//    }
    
    
    
}

