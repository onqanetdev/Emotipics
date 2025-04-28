//
//  SubmitButton.swift
//  Emotipics
//
//  Created by Onqanet on 28/04/25.
//

import Foundation
import UIKit




class SubmitButton: UIView {

    let plusViewBtn: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitleColor(UIColor(cgColor: #colorLiteral(red: 0, green: 0.1647058824, blue: 0.3450980392, alpha: 0.5164636271).cgColor) , for: .normal)
        btn.backgroundColor = #colorLiteral(red: 0.8039215686, green: 0.9764705882, blue: 1, alpha: 1)
        btn.titleLabel?.font = .systemFont(ofSize: 20, weight: .bold)
       // btn.setImage(UIImage(named: "PlusIcon"), for: .normal)
        btn.layer.cornerRadius = 25
        btn.layer.borderColor = #colorLiteral(red: 0, green: 0.1647058824, blue: 0.3450980392, alpha: 0.5164636271)
        btn.layer.borderWidth = 2
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
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
        addSubview(plusViewBtn)
        
        // Constraints for button to fill the view
        NSLayoutConstraint.activate([
            plusViewBtn.topAnchor.constraint(equalTo: topAnchor),
            plusViewBtn.leadingAnchor.constraint(equalTo: leadingAnchor),
            plusViewBtn.trailingAnchor.constraint(equalTo: trailingAnchor),
            plusViewBtn.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}
