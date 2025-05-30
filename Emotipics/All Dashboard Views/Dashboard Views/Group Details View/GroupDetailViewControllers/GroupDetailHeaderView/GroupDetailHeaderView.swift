//
//  GroupDetailHeaderView.swift
//  Emotipics
//
//  Created by Onqanet on 29/05/25.
//

import UIKit

class GroupDetailHeaderView: UIView {
    
    public let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.image = UIImage(named: "BlackGroup")
        iv.tintColor = .label
        return iv
    }()
    
    
    
    public let bgView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = #colorLiteral(red: 0.8196078431, green: 0.9058823529, blue: 1, alpha: 1)
        view.layer.cornerRadius = 30
        return view
    }()
    
    
    public let manageLbl: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Management Team"
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = .black
        return label
    }()
    
    
    public let usersLbl: UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "10 Users"
        lbl.textColor = .systemGray2
        return lbl
    }()
    
    
    public let actionBtn: UIButton = {
       let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        btn.tintColor = #colorLiteral(red: 0.5254901961, green: 0.5215686275, blue: 0.5764705882, alpha: 1)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(bgView)
        bgView.addSubview(imageView)
        self.addSubview(manageLbl)
        self.addSubview(usersLbl)
        self.addSubview(actionBtn)
        
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([

            bgView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            bgView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            bgView.heightAnchor.constraint(equalToConstant: 60),
            bgView.widthAnchor.constraint(equalToConstant: 60),
            
            manageLbl.leadingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: 14),
            manageLbl.topAnchor.constraint(equalTo: bgView.topAnchor, constant: 3),
        
            usersLbl.leadingAnchor.constraint(equalTo: manageLbl.leadingAnchor),
            usersLbl.topAnchor.constraint(equalTo: manageLbl.bottomAnchor, constant: 3),
            
            actionBtn.heightAnchor.constraint(equalToConstant: 35),
            actionBtn.widthAnchor.constraint(equalToConstant: 35),
            actionBtn.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15),
            actionBtn.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            
            imageView.centerXAnchor.constraint(equalTo: bgView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: bgView.centerYAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 30),
            imageView.widthAnchor.constraint(equalToConstant: 30),
            
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
