//
//  ContactsView.swift
//  Emotipics
//
//  Created by Onqanet on 11/03/25.
//

import UIKit

class ContactsView: UIView {

    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "ShowFolder")
        iv.tintColor = .label
        return iv
    }()
    
    private let contactsLbl: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: textInputStyle.latoBold.rawValue, size: 20)
        label.text = "My Contacts"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        //self.addSubview(imageView)
        self.addSubview(contactsLbl)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contactsLbl.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 25),
            contactsLbl.topAnchor.constraint(equalTo: self.topAnchor, constant: 40),
            contactsLbl.heightAnchor.constraint(equalToConstant: 20),
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
