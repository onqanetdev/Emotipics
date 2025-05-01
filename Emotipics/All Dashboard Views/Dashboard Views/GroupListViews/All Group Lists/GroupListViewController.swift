//
//  GroupListViewController.swift
//  Emotipics
//
//  Created by Onqanet on 17/03/25.
//

import UIKit

class GroupListViewController: UIViewController, DeleteCatalogDelegate {


    @IBOutlet weak var groupHeadingLbl: UILabel!{
        didSet {
            groupHeadingLbl.font = UIFont(name: textInputStyle.latoBold.rawValue, size: 25)
        }
    }
    
    
    @IBOutlet weak var curvedView: UIView! {
        didSet {
            curvedView.layer.cornerRadius = 35
            curvedView.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var tblViewForGroups: UITableView!
    
    //Variable For modification
    var notificationView: Bool = false
    
    
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    
    
    
    
    
    private var submitButton: SubmitButton = {
        let btn = SubmitButton()
        btn.plusViewBtn.setTitle("Create Group", for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.plusViewBtn.addTarget(self, action: #selector(groupCreate), for: .touchUpInside)
        return btn
    }()
    
    
    
    //  var createGroupViewModel: CreateGroupViewModel = CreateGroupViewModel()
    
    var  groupListingView: GroupListViewModel = GroupListViewModel()
    
    
    private var loaderView: ImageLoaderView?
    
    
    var newResultArray:[GroupData] = []
    
    var indexNo: Int = 0
    
    
    var groupDeleteViewModel: GroupDeleteViewModel = GroupDeleteViewModel()
    
    
    var groupUserExitViewModel: GroupUserExitViewModel = GroupUserExitViewModel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        tblViewForGroups.dataSource = self
        tblViewForGroups.delegate = self
        
        
        //Formation of the code if true
        
        if notificationView {
            groupHeadingLbl.text = "Notifications"
            
            topConstraint.constant = 20
            
            tblViewForGroups.register(UINib(nibName: "NotificationViewCell", bundle: nil), forCellReuseIdentifier: "NotificationCell")
            tblViewForGroups.separatorStyle = .none
            
            
            
        } else {
            
            topConstraint.constant = 0
            
            tblViewForGroups.register(UINib(nibName: "GroupTableViewCell", bundle: nil), forCellReuseIdentifier: "Group")
            
            let backgroundImage = UIImage(named: "TableViewBackground")
            let backgroundImageView = UIImageView(image: backgroundImage)
            backgroundImageView.contentMode = .scaleAspectFill
            tblViewForGroups.backgroundView = backgroundImageView
            
            // Make table view background transparent so image shows through cells
            tblViewForGroups.backgroundColor = .clear
        }
        
        
        addPlusIcon()
        loadingAllGroups()
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        //self.tabBarController?.editButtonItem.isHidden = true
        if let tabBarController = self.tabBarController {
            for subview in tabBarController.view.subviews {
                if let button = subview as? UIButton,
                   button.backgroundImage(for: .normal) == UIImage(named: "PlusIcon") {
                    button.isHidden = true
                }
            }
        }
        
        loadingAllGroups()
    }
    
    
    
    
    func addPlusIcon(){
        // floatingBtn.addSubview(Flo)
        view.addSubview(submitButton)
        
        NSLayoutConstraint.activate([
            submitButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            submitButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            submitButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            submitButton.heightAnchor.constraint(equalToConstant: 60)
            
        ])
        
    }
    
    
    @IBAction func backToPreVious(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        
    }
    
    
    @objc func groupCreate(){
        // print("Test 123")
        navigationController?.pushViewController(CreateNewViewController(), animated: true)
    }
    
    
    
    
    func loadingAllGroups() {
        groupListingView.requestModel.limit = "10"
        groupListingView.requestModel.offset = "1"
        //activityIndicator.startAnimating()
        startCustomLoader()
        
        groupListingView.groupListViewModelFunc(request: groupListingView.requestModel) { result in
            DispatchQueue.main.async { [self] in
                // self.activityIndicator.stopAnimating()
                self.stopCustomLoader()
                switch result {
                case .goAhead:
                    print("✅ Data received successfully!")
                    guard let resultArray = groupListingView.responseModel?.data else {
                        return
                    }
                    
                    newResultArray = resultArray
                    self.tblViewForGroups.reloadData()
                    
                    
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
    
    
    @objc func deleteUser(_ sender: UIButton){

        guard let userCode = UserDefaults.standard.string(forKey: "userCode") else {
                return
            }
        
        guard let groupOwnerCode = groupListingView.responseModel?.data?[sender.tag].owner_detials?.code else {
            return
        }
        

        
        if userCode == groupOwnerCode {
            print("User Code : \(userCode) and Group Owner code is \(groupOwnerCode)")
            detailsPopUp(index:sender.tag)
        } else {
            //print("Group Code")
            exitFromGroupPopUp(index: sender.tag)
        }
        
        
//        print("User code is: \(userCode)")
//        detailsPopUp(index:sender.tag)
        
        
    }
    
    
    
    func deleteCatalogGlobalPopUp() {
        let errorPopup = DeleteCatalogueGlobalPopUp(nibName: "DeleteCatalogueGlobalPopUp", bundle: nil)
        errorPopup.modalPresentationStyle = .overCurrentContext
        errorPopup.modalTransitionStyle = .crossDissolve
        errorPopup.delegate = self
        self.present(errorPopup, animated: true)
        
        
    }
    
    
    
    func deletePopup() {
        //Implement the delete function
        
       print("Hello --> ", indexNo)
        
       deleteGroup(groupIndex: indexNo)
        
        
    }
    
    func deleteGroup(groupIndex: Int){
        groupDeleteViewModel.requestModel.groupCode = newResultArray[groupIndex].group_code ?? "0"
        
        //activityIndicator.startAnimating()
        startCustomLoader()
        
        groupDeleteViewModel.groupDeleteViewModel(request: groupDeleteViewModel.requestModel) { result in
            DispatchQueue.main.async { [self] in
                // self.activityIndicator.stopAnimating()
                stopCustomLoader()
                switch result {
                case .goAhead:
                    print("Hello")
                    newResultArray.remove(at: groupIndex)
                    tblViewForGroups.reloadData()
                case .heyStop:
                    print("Error")
                }
                
                
            }
            
            
        }
    }
    
    
}



extension GroupListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newResultArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if notificationView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as! NotificationViewCell
            cell.selectionStyle = .none
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Group", for: indexPath) as! GroupTableViewCell
            cell.backgroundColor = .clear
            cell.layer.cornerRadius = 25
            cell.clipsToBounds = true
            cell.selectionStyle = .none
            
            cell.grpName.text = newResultArray[indexPath.row].groupname
            cell.noOfUsers.text = String(newResultArray[indexPath.row].members ?? 0) + " users"
            
            cell.aboutBtn.tag = indexPath.row
            cell.aboutBtn.addTarget(self, action: #selector(deleteUser(_ :)), for: .touchUpInside)
            
            
            return cell
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //return 130
        if notificationView {
            return 90
        } else {
            return 130
        }
        
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if notificationView {
            print("This is notification view")
            let notificationDetailsView = NotificationDetailsVC()
            navigationController?.pushViewController(notificationDetailsView, animated: true)
            
        } else {
            let groupDetailView = GroupDetailViewController()
            navigationController?.pushViewController(groupDetailView, animated: true)
        }
    }
    
}
