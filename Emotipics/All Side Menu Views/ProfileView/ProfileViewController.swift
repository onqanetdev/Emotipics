//
//  ProfileViewController.swift
//  Emotipics
//
//  Created by Onqanet on 21/03/25.
//

import UIKit


protocol ProfileViewControllerDelegate: AnyObject {
    func didSelectMenuItem()
}








class ProfileViewController: UIViewController {

    
    
    @IBOutlet weak var sideMenuTableView: UITableView!
    
    
    
    var contentsTitle = ["Home", "My Account", "Catalogue", "Contact List","Shared Image List", "Groups", "About Us", "Terms & Conditions", "Support", "Logout"]
    
    var respectiveImg = ["Home","MyAccount", "Catalogue", "ContactList", "sharedImageList", "Group", "About Us", "Terms", "Support", "Logout"]
    
    
    
    
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var userEmail: UILabel!
    
    weak var delegate: ProfileViewControllerDelegate?
   
    
    private var loaderView: ImageLoaderView?
    
    var profileDetailsViewModel: ProfileDetailsViewModel = ProfileDetailsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.sideMenuTableView.delegate = self
        self.sideMenuTableView.dataSource = self
        self.sideMenuTableView.backgroundColor = .white
        self.sideMenuTableView.separatorStyle = .singleLine
        
        self.sideMenuTableView.register(UINib(nibName: "SideMenuCell", bundle: nil), forCellReuseIdentifier: "SideBarCell")
        
        print("Screen Height: \(UIScreen.main.bounds.height)")
        
        let screenHeight = UIScreen.main.bounds.height
        
        //self.sideMenuTableView.isScrollEnabled = screenHeight < 750
        
        
        userName.font = UIFont(name: textInputStyle.poppinsMedium.rawValue, size: 18)
        userEmail.font = UIFont(name: textInputStyle.poppinsRegular.rawValue, size: 15)
        
        
        //sideMenuManager.setup(in: self)

        loadAllProfileDetails()
    }
    
    
    
    func loadAllProfileDetails(){
       // createGroupViewModel.requestModel.groupName = groupName
        
        //activityIndicator.startAnimating()
        startCustomLoader()
        
        profileDetailsViewModel.profileDetailsViewModel { result in
            DispatchQueue.main.async { [weak self] in
                // self.activityIndicator.stopAnimating()
                self?.stopCustomLoader()
                switch result {
                case .goAhead:
                    print("Profile Updated")
                    self?.userName.text = self?.profileDetailsViewModel.responseModel?.user?.name
                    self?.userEmail.text = self?.profileDetailsViewModel.responseModel?.user?.email
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

extension ProfileViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contentsTitle.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SideBarCell", for: indexPath) as? SideMenuCell else { fatalError("xib doesn't exist") }
        //cell.textLabel?.text = "The Number of the Cell\(indexPath.row)"
        cell.myTitleLbl.text = contentsTitle[indexPath.row]
        cell.imgViewTitle.image = UIImage(named: respectiveImg[indexPath.row])?.withRenderingMode(.alwaysTemplate)
        cell.imgViewTitle.tintColor = .black
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 57
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
       
        
       // sideMenuManager.toggleSideMenu()
        
        delegate?.didSelectMenuItem()
        
        //self.dismiss(animated: true)
        
        if contentsTitle[indexPath.row] == "My Account" {
            navigationController?.pushViewController(MyAccountDetailsVC(), animated: true)
        } else if contentsTitle[indexPath.row] == "About Us" {
            let aboutUs = AboutUsVC()
            aboutUs.aboutUsTitleText = "About Us"
            navigationController?.pushViewController(aboutUs, animated: true)
            //navigationController?.pushViewController(AboutUsVC(), animated: true)
        } else if contentsTitle[indexPath.row] == "Terms & Conditions" {
            let termsView = AboutUsVC()
            termsView.aboutUsTitleText = "Terms & Conditions"
            //termsView.aboutusTitle.text = "Terms & Conditions"
            navigationController?.pushViewController(termsView, animated: true)
        } else if contentsTitle[indexPath.row] == "Support" {
            let supportView = AboutUsVC()
            supportView.aboutUsTitleText = "Support"
            //supportView.aboutusTitle.text = "Support"
            navigationController?.pushViewController(supportView, animated: true)
        } else if contentsTitle[indexPath.row] == "Catalogue" {
            navigationController?.pushViewController(CatalogueViewController(), animated: true)
        } else if contentsTitle[indexPath.row] == "Contact List" {
            navigationController?.pushViewController(ContactsViewController(), animated: true)
        } else if contentsTitle[indexPath.row] == "Shared Image List" {
            navigationController?.pushViewController(SharedImageByMeVC(), animated: true)
            
        }else if contentsTitle[indexPath.row] == "Groups" {
            navigationController?.pushViewController(GroupListViewController(), animated: true)
        } else if contentsTitle[indexPath.row] == "Logout" {
            print("log Out")
            SessionManager.shared.logoutUser()
        }
    }
    
}
