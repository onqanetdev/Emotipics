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
    
    
    var catalogCode = ""
    
    var catalogueUserListViewModel: CatalogueUserListViewModel = CatalogueUserListViewModel()
    
    //Group sharing Information
    
    var groupSharingVC: Bool = false
    
    var grpTempMemory:[ShareByMe] = []
    
    var grpUserListViewModel: GroupUserListViewModel = GroupUserListViewModel()
    
    var groupCode:String = ""
    var groupUserList:[GroupUserListData] = []
    
    
    var groupUserDeleteViewModel: GroupUserDeleteViewModel = GroupUserDeleteViewModel()
    
    
    
    var isButtonShown:Bool = false
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        sharedConListTblView.dataSource = self
        sharedConListTblView.delegate = self
        sharedConListTblView.register(UINib(nibName: "SharedInformationTVC", bundle: nil), forCellReuseIdentifier: "SharingTVC")
        
        
        loadingViewsAcc()
        
        
        if isButtonShown {
            addUserBtn.isHidden = true
        } else {
            addUserBtn.isHidden = false
        }
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadingViewsAcc()
        
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
        
        if groupSharingVC {
            print("Deleted Conatact would be", groupUserList[sender.tag].id)
            
            guard let groupUserId = groupUserList[sender.tag].id else {
                return
            }
            
            groupUserDelete(contactId: groupUserId, removeAt: sender.tag)
            
        }
        else
        {
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
    }
    
    func userListForGrp(){
        grpUserListViewModel.requestModel.groupCode = groupCode
        startCustomLoader()
        grpUserListViewModel.groupAddUserViewModel(request: grpUserListViewModel.requestModel)
        { result in
            DispatchQueue.main.async {
                //self.activityIndicator.stopAnimating()
                self.stopCustomLoader()
                switch result {
                case .goAhead:
                    print("Group User List Loaded✅")
                    //table View Reload Data
                    DispatchQueue.main.async { [self] in
                        //                        self.groupUserList = grpUserListViewModel.responseModel?.data ?? <#default value#>
                        
                        guard let userGroup = grpUserListViewModel.responseModel?.data else {
                        
                           // AlertView.showAlert("Warning!", message: "", okTitle: <#T##String#>)
                            
                            return
                        }
                        self.groupUserList = userGroup
                        
                        self.sharedConListTblView.reloadData()
                        
                    }
                case .heyStop:
                    print("Error")
                }
                
                
            }
            
            
        }
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
        
        if groupSharingVC {
            //return grpTempMemory.count
            return groupUserList.count
        } else {
            return temporaryMemory.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if groupSharingVC {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SharingTVC", for: indexPath) as! SharedInformationTVC
            
            //            cell.sharedContactLbl.text = grpTempMemory[indexPath.row].groupcontact?.contactdetails?.name
            
            cell.sharedContactLbl.text = groupUserList[indexPath.row].groupcontact?.contactdetails?.name
            
            cell.deleteSharedBtn.tag = indexPath.row
            
            cell.deleteSharedBtn.addTarget(self, action: #selector(respectiveContactCode(_ :)), for: .touchUpInside)
            
            return cell
            
            
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SharingTVC", for: indexPath) as! SharedInformationTVC
            cell.sharedContactLbl.text = temporaryMemory[indexPath.row].contactlist?.contactdetails?.name
            
            cell.deleteSharedBtn.tag = indexPath.row
            
            cell.deleteSharedBtn.addTarget(self, action: #selector(respectiveContactCode(_ :)), for: .touchUpInside)
            
            return cell
            
        }
    }
    
    
}
