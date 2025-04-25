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
    
    
    let catalogueUserDeleteViewModel: CatalogueUserDeleteViewModel = CatalogueUserDeleteViewModel()
    
    
    private var loaderView: ImageLoaderView?
    
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
    
    
    
    @objc func respectiveContactCode(_ sender: UIButton) {
        
        print("Deleted Contact code would be", temporaryMemory[sender.tag].contactcode as Any)
        
        print("The folder code would be--->", temporaryMemory[sender.tag].catalogcode)
        print("The User That Should be deleted", temporaryMemory[sender.tag].id)
        
        
        guard let contactId = temporaryMemory[sender.tag].id else {
            AlertView.showAlert("Warning!", message: "Not Able to Fetch Contact Id", okTitle: "OK")
            return
        }
        //Deleting user from respective folder
        catalogueUserDelete(folderContactCode: contactId, removeAt: sender.tag)
        
    }
    
    func catalogueUserDelete(folderContactCode:Int, removeAt: Int){
        catalogueUserDeleteViewModel.requestModel.contactCode = folderContactCode
        startCustomLoader()
        catalogueUserDeleteViewModel.catalogueUserDeleteViewModel(request: catalogueUserDeleteViewModel.requestModel) { result in
            DispatchQueue.main.async {
                //self.activityIndicator.stopAnimating()
                self.stopCustomLoader()
                switch result {
                case .goAhead:
                    print("Shared Catalogue View Model From Shared Catalogue View Controller")
                    //table View Reload Data
                    DispatchQueue.main.async { [self] in
                        temporaryMemory.remove(at: removeAt)
                        self.sharedConListTblView.reloadData()
                        
                    }
                case .heyStop:
                    print("Error")
                }
                
                
            }
            
            
        }
    }
    
    
    func startCustomLoader(){
        //        let loaderSize: CGFloat = 220
        
        if loaderView != nil { return }
        let loader = ImageLoaderView(frame: view.bounds)
        loader.center = view.center
        loader.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        loader.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        //loader.layer.cornerRadius = 16
        
        view.addSubview(loader)
        loader.startAnimating()
        
        self.loaderView = loader
        
        // Stop and remove after 5 seconds
    }
    func stopCustomLoader(){
        print("Trying to stop loader:", loaderView != nil)
        loaderView?.stopAnimating()
        loaderView?.removeFromSuperview()
        
        loaderView = nil
        
        
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
        
        cell.deleteSharedBtn.tag = indexPath.row
        
        cell.deleteSharedBtn.addTarget(self, action: #selector(respectiveContactCode(_ :)), for: .touchUpInside)
        
        return cell
    }
    
    
}
