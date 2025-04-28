//
//  GroupListViewController.swift
//  Emotipics
//
//  Created by Onqanet on 17/03/25.
//

import UIKit

class GroupListViewController: UIViewController {

    
    
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
    
    
    private var loaderView: ImageLoaderView?
    
    
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



extension GroupListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        
        if notificationView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "NotificationCell", for: indexPath) as! NotificationViewCell
//           cell.backgroundColor = .clear
//            cell.layer.cornerRadius = 25
//            cell.clipsToBounds = true
            cell.selectionStyle = .none
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Group", for: indexPath) as! GroupTableViewCell
           cell.backgroundColor = .clear
            cell.layer.cornerRadius = 25
            cell.clipsToBounds = true
            cell.selectionStyle = .none
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
