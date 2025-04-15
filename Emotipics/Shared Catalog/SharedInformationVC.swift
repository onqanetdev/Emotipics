//
//  SharedInformationVC.swift
//  Emotipics
//
//  Created by Onqanet on 11/04/25.
//

import UIKit

class SharedInformationVC: UIViewController {
    
    
    
    @IBOutlet weak var sharedView: UIView!{
        didSet {
            sharedView.layer.cornerRadius = 25
            sharedView.clipsToBounds = true
        }
    }
    
    
    @IBOutlet weak var addUserBtn: UIButton!{
        didSet {
            addUserBtn.layer.cornerRadius = 10
            addUserBtn.clipsToBounds = true
            addUserBtn.layer.borderColor = #colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1).cgColor
            addUserBtn.layer.borderWidth = 1
        }
    }
    
    
    

    
    @IBOutlet weak var emptyView: UIView!{
        didSet{
            emptyView.isHidden = true
        }
    }
    
    
    @IBOutlet weak var catalogueName: UILabel!
    
    
    
    
    
    
    
    
    
    weak var delegate: SharedInformationDelegate?
    

    @IBOutlet weak var sharedConListTblView: UITableView!{
        didSet{
            sharedConListTblView.isHidden = true
        }
    }
    
    var temporaryMemory:[Sharedcatalog] = []
    
    
    var catalogueNameText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        sharedConListTblView.dataSource = self
        sharedConListTblView.delegate = self
        sharedConListTblView.register(UINib(nibName: "SharedInformationTVC", bundle: nil), forCellReuseIdentifier: "SharingTVC")
        
        
        if temporaryMemory.count == 0 {
            emptyView.isHidden = false
            sharedConListTblView.isHidden = true
        } else {
            emptyView.isHidden = true
            sharedConListTblView.isHidden = false
        }
        
        catalogueName.text = catalogueNameText
        
        
    }


    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let location = touch.location(in: self.view)
        
        if !sharedView.frame.contains(location) {
            self.dismiss(animated: true, completion: nil)
        }
    }

    

    @IBAction func addUserBtn(_ sender: Any) {
                
        self.dismiss(animated: true) {
                    self.delegate?.didTapProceed()
                }
            }
    }
    




extension SharedInformationVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       // return 2
        return temporaryMemory.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SharingTVC", for: indexPath) as! SharedInformationTVC
        cell.sharedContactLbl.text = temporaryMemory[indexPath.row].contactlist?.contactdetails?.name
        
        return cell
    }
    
    
}
