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
        
        cell.sarahLbl.text = contactsViewModel.responseModel?.data?[indexPath.row].contactdetails?.name
        cell.associatedEmailTxtFld.text = contactsViewModel.responseModel?.data?[indexPath.row].contactdetails?.email
        
        cell.layer.cornerRadius = 10
        cell.moreActionBtn.tag = indexPath.row
        cell.moreActionBtn.addTarget(self, action: #selector(popUpFromBottom(_:)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("user code", contactsViewModel.responseModel?.data?[indexPath.row].contactdetails?.code)
    }
    
    
    
}

