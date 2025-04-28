//
//  FloatingBtn.swift
//  Emotipics
//
//  Created by Onqanet on 11/03/25.
//

import UIKit

class FloatingBtn: UIView {
    
    
    
    
    public var plusViewBtn: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setBackgroundImage(UIImage(named: "PlusIcon"), for: .normal)
       // btn.setBackgroundImage(UIImage(systemName: "plus.circle.fill"), for: .normal)
        btn.layer.cornerRadius = 25
        btn.clipsToBounds = true
        return btn
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(plusViewBtn)
        
        NSLayoutConstraint.activate([
     
            plusViewBtn.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            plusViewBtn.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            plusViewBtn.heightAnchor.constraint(equalToConstant: 60),
            plusViewBtn.widthAnchor.constraint(equalToConstant: 60)
            
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    
    func setTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event) {
        plusViewBtn.addTarget(target, action: action, for: controlEvents)
    }

    
}
