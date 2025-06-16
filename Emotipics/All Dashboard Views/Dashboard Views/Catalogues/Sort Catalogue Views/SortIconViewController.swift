//
//  SortIconViewController.swift
//  Emotipics
//
//  Created by Onqanet on 13/06/25.
//

import UIKit

class SortIconViewController: UIViewController {
    
    
    
    @IBOutlet weak var sortingBg: UIView!{
        didSet {
            sortingBg.layer.cornerRadius = 40
            sortingBg.clipsToBounds = true
        }
    }
    
    
    
    @IBOutlet weak var sortingOrderLbl: UILabel!
    
    
    @IBOutlet weak var newestFirstBtn: UIButton!
    
    
    @IBOutlet weak var oldestFirstBtn: UIButton!
    
    var onTapNewestFirst: (() -> Void)?
    
    var onTapOldestFirst: (() -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self.view)
        
        if !sortingBg.frame.contains(location) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
   
    
    
    
    @IBAction func newestFirstCatalogue(_ sender: Any) {
        
        self.dismiss(animated: true) {
            self.onTapNewestFirst?()
            
        }
    }
    
    
    @IBAction func oldestFirstCatalogue(_ sender: Any) {
        
        self.dismiss(animated: true) {
            self.onTapOldestFirst?()
           
        }
        
    }
    
}
