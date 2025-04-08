//
//  EmptyCollView.swift
//  Emotipics
//
//  Created by Onqanet on 08/04/25.
//

import UIKit

class EmptyCollView: UIView {

    private var imgPhoto: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "uploadcata")
        return image
    }()

    
    private var noCatLbl:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "No Catalogue Found!"
        label.font = UIFont(name: textInputStyle.latoBold.rawValue, size: 18)
        return label
    }()
    
    
    
    private var addSomeCat:UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Add some catalogue to get start"
        label.font = UIFont(name: textInputStyle.latoRegular.rawValue, size: 14)
        label.textColor = .gray
        return label
    }()
    
    
    
    private var addBtn: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Add Catalogue", for: .normal)
        button.setTitleColor(.systemTeal, for: .normal)
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.systemTeal.cgColor
        button.clipsToBounds = true
        return button
    }()
    
    
    
    
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
        NSLayoutConstraint.activate([
            imgPhoto.topAnchor.constraint(equalTo: self.topAnchor, constant: 2),
            imgPhoto.widthAnchor.constraint(equalToConstant: 45),
            imgPhoto.heightAnchor.constraint(equalToConstant: 45),
            imgPhoto.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            
            noCatLbl.topAnchor.constraint(equalTo: imgPhoto.bottomAnchor, constant: 2),
            noCatLbl.widthAnchor.constraint(equalToConstant: 100),
            noCatLbl.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            addSomeCat.topAnchor.constraint(equalTo: noCatLbl.bottomAnchor, constant: 2),
            addSomeCat.widthAnchor.constraint(equalToConstant: 150),
            addSomeCat.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            
            addBtn.topAnchor.constraint(equalTo: addSomeCat.bottomAnchor, constant: 10),
            addBtn.widthAnchor.constraint(equalToConstant: 80),
            addBtn.heightAnchor.constraint(equalToConstant: 50),
            addBtn.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            

        ])
    }
}
