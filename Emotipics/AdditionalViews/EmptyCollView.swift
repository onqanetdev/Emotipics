//
//  EmptyCollView.swift
//  Emotipics
//
//  Created by Onqanet on 08/04/25.
//

import UIKit

class EmptyCollView: UIView {

    public var imgPhoto: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "uploadcata")
        image.contentMode = .scaleToFill
        return image
    }()

    
    public var noCatLbl:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "No Catalogue Found!"
        label.font = UIFont(name: textInputStyle.latoBold.rawValue, size: 14)
        label.textAlignment = .center
        return label
    }()
    
    
    
    public var addSomeCat:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Add some catalogue to get start"
        label.font = UIFont(name: textInputStyle.latoRegular.rawValue, size: 13)
        label.textColor = .gray
        label.textAlignment = .center
        return label
    }()
    
    
    
    public var addBtn: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Add Catalogue", for: .normal)
        button.setTitleColor(.systemTeal, for: .normal)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.systemTeal.cgColor
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        return button
    }()
    
    
    public var imgWidthConstraint: NSLayoutConstraint!
    public var imgHeightConstraint: NSLayoutConstraint!

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    
    
    
    private func setupView() {
        addSubview(imgPhoto)
        addSubview(noCatLbl)
        addSubview(addSomeCat)
        addSubview(addBtn)
        settingUpConstraints()
    }
    
    
    func settingUpConstraints() {
        
        imgWidthConstraint = imgPhoto.widthAnchor.constraint(equalToConstant: 95)
        imgHeightConstraint = imgPhoto.heightAnchor.constraint(equalToConstant: 75)
        
        NSLayoutConstraint.activate([
            imgPhoto.topAnchor.constraint(equalTo: self.topAnchor, constant: 2),
            //imgPhoto.widthAnchor.constraint(equalToConstant: 95),
            imgWidthConstraint,
           // imgPhoto.heightAnchor.constraint(equalToConstant: 75),
            imgHeightConstraint,
            imgPhoto.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            
            noCatLbl.topAnchor.constraint(equalTo: imgPhoto.bottomAnchor, constant: 2),
            noCatLbl.widthAnchor.constraint(equalToConstant: 200),
            noCatLbl.centerXAnchor.constraint(equalTo: imgPhoto.centerXAnchor),
            
            addSomeCat.topAnchor.constraint(equalTo: noCatLbl.bottomAnchor, constant: 2),
            addSomeCat.widthAnchor.constraint(equalToConstant: 210),
            addSomeCat.centerXAnchor.constraint(equalTo: imgPhoto.centerXAnchor),
            
            
            addBtn.topAnchor.constraint(equalTo: addSomeCat.bottomAnchor, constant: 10),
            addBtn.heightAnchor.constraint(equalToConstant: 35),
            addBtn.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            addBtn.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            addBtn.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            

        ])
    }
}



