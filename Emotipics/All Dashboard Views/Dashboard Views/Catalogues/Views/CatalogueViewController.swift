//
//  CatalogueViewController.swift
//  Emotipics
//
//  Created by Onqanet on 11/03/25.
//

import UIKit

class CatalogueViewController: UIViewController {
    
    
    @IBOutlet weak var catalougeCollView: UICollectionView!
    @IBOutlet weak var sharedCatalogueCollView: UICollectionView!
    
    
    @IBOutlet weak var catalogueLbl: UILabel! {
        didSet{
            catalogueLbl.font = UIFont(name: textInputStyle.latoBold.rawValue, size: 25)
        }
    }
    
    @IBOutlet weak var backGroundView: UIView!{
        didSet{
            backGroundView.layer.cornerRadius = 35
            backGroundView.clipsToBounds = true
        }
    }
    
    
    
    @IBOutlet weak var myCatalogueLbl: UILabel!{
        didSet{
            myCatalogueLbl.font = UIFont(name: textInputStyle.latoBold.rawValue, size: 17)
        }
    }
    
    
    @IBOutlet weak var myCatalogueViewAllBtn: UIButton!{
        didSet{
            myCatalogueViewAllBtn.titleLabel?.font = UIFont(name: textInputStyle.latoRegular.rawValue, size: 15)
        }
    }
    
    //MARK: Height contraints
    
    
    @IBOutlet weak var sharedCollViewHeight: NSLayoutConstraint!
    @IBOutlet weak var myCatalogueHeightConst: NSLayoutConstraint!
    
    @IBOutlet weak var myCatalogueViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var myCatalogueCollViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var sharedCatalogueViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var borderHeight: NSLayoutConstraint!
    
    
    
    
    
    
    @IBOutlet weak var heightOfContScrollView: NSLayoutConstraint!
    
    
    @IBOutlet weak var sharedCatalogueLbl: UILabel!{
        didSet{
            sharedCatalogueLbl.font = UIFont(name: textInputStyle.latoBold.rawValue, size: 17)
        }
    }
    
    
    @IBOutlet weak var viewAllSharedBtn: UIButton!{
        didSet{
            viewAllSharedBtn.titleLabel?.font = UIFont(name: textInputStyle.latoRegular.rawValue, size: 15)
        }
    }
    
    
    
    private var floatingBtn: UIView = {
        let btn = FloatingBtn()
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    
    
    var catalogueListingViewModel:CatalogueListingViewModel = CatalogueListingViewModel()
    var sharedCatalogueViewModel:CatalogueListingViewModel = CatalogueListingViewModel()
    
    var loginViewModel:LoginViewModel = LoginViewModel()
    
    var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .systemOrange
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        catalougeCollView.dataSource = self
        catalougeCollView.delegate = self
        
        sharedCatalogueCollView.dataSource = self
        sharedCatalogueCollView.delegate = self
        
        //catalougeCollView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Sample")
        
        catalougeCollView.register(UINib(nibName: "EntryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        
//        sharedCatalogueCollView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Demo")
        
        sharedCatalogueCollView.register(UINib(nibName: "EntryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
       // var heightOfTotalComponents:CGFloat = 28 + 252 + 28 + 330 + 1
        heightOfContScrollView.constant = 825
        addPlusIcon()
        
        setupActivityIndicator()
        
        allCatalogueList()
        
        sharedCatalogueList()
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
        allCatalogueList()
        sharedCatalogueList()
    }
    
    
    
    func setupActivityIndicator() {
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        activityIndicator.transform = CGAffineTransform(scaleX: 3.0, y: 3.0)
        
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden = true
        allCatalogueList()
        sharedCatalogueList()
    }
    
    func addPlusIcon(){
       // floatingBtn.addSubview(Flo)
        view.addSubview(floatingBtn)
        
        NSLayoutConstraint.activate([
            floatingBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -90),
            floatingBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            floatingBtn.heightAnchor.constraint(equalToConstant: 60),
            floatingBtn.widthAnchor.constraint(equalToConstant: 60)
        ])
        
    }
    
    
    
    
    func allCatalogueList(){
        catalogueListingViewModel.requestModel.limit = "4"
        catalogueListingViewModel.requestModel.offset = "1"
        catalogueListingViewModel.requestModel.sort_folder = "DESC"
        catalogueListingViewModel.requestModel.type_of_list = "catalog_lists"
        
        activityIndicator.startAnimating()
        
        catalogueListingViewModel.catalogueListing(request: catalogueListingViewModel.requestModel) { result in
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                
                switch result {
                case .goAhead:
                    print("Catalogue View Model from Catalogue View Controller")
                    //table View Reload Data
                    
                    
                    DispatchQueue.main.async { [self] in
                        catalougeCollView.reloadData()
                        
                   }
                case .heyStop:
                    print("Error")
                }
                
                
            }
            
            
        }
    } // Add Catalogue Ending
    
    func sharedCatalogueList(){
        sharedCatalogueViewModel.requestModel.limit = "4"
        sharedCatalogueViewModel.requestModel.offset = "1"
        sharedCatalogueViewModel.requestModel.sort_folder = "DESC"
        sharedCatalogueViewModel.requestModel.type_of_list = "share_all_catalog"
        
        activityIndicator.startAnimating()
        
        sharedCatalogueViewModel.catalogueListing(request: sharedCatalogueViewModel.requestModel) { result in
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                
                switch result {
                case .goAhead:
                    print("Shared Catalogue View Model 🫡 🫡 View Controller")
                    //table View Reload Data
                    DispatchQueue.main.async { [self] in

                        sharedCatalogueCollView.reloadData()
                        
                   }
                case .heyStop:
                    print("Error")
                }
                
                
            }
            
            
        }
    }
    
    
    
    
    
    
    
    @IBAction func previousPage(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func myCatalogueViewAction(_ sender: Any) {
        
        navigationController?.pushViewController(AllCataloguesViewController(), animated: true)
        
        print("Moving to Next View Controller")
    }
    
    
    
    
    @IBAction func showAllSharedCatalogue(_ sender: Any) {
        
        print("Moving to next view controller")
    }
    
    
    
    
    @IBAction func SharedViewAllBtn(_ sender: Any) {
        
        navigationController?.pushViewController(SharedCatalogueViewController(), animated: true)
        
        
    }
}






extension CatalogueViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == catalougeCollView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! EntryCollectionViewCell
            
//            cell.backgroundColor = .red // Differentiate visually
            cell.layer.cornerRadius = 15
            cell.projectFilesLbl.text = catalogueListingViewModel.responseModel?.data?[indexPath.row].catalog_name ?? "Project Files"
            cell.noOfFiles.text = catalogueListingViewModel.responseModel?.data?[indexPath.row].total_files ?? "0"
            cell.fiveGbLbl.text = catalogueListingViewModel.responseModel?.data?[indexPath.row].file_storage ?? "0"
            
            
            
            cell.clipsToBounds = true
            return cell
        } else { // sharedCatalogueCollView
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! EntryCollectionViewCell
//            cell.backgroundColor = .blue // Differentiate visually
            cell.layer.cornerRadius = 25
            cell.clipsToBounds = true
            
            

            print("Desired Mail id is", sharedCatalogueViewModel.responseModel?.data?[indexPath.row].owner_detials?.email)
            
            
            guard let ownerMailId = sharedCatalogueViewModel.responseModel?.data?[indexPath.row].owner_detials?.email else {
                return cell
            }
            
            guard let savedEmail = UserDefaults.standard.string(forKey: "userEmail") else {
                return cell
            }

            if ownerMailId == savedEmail {
                cell.sharedByLbl.text = "Share with other"
            } else {
                cell.sharedByLbl.text = "Share by " + (sharedCatalogueViewModel.responseModel?.data?[indexPath.row].owner_detials?.name ?? "nil")
            }
            
            cell.projectFilesLbl.text = sharedCatalogueViewModel.responseModel?.data?[indexPath.row].catalog_name ?? "Nil"
            cell.noOfFiles.text = sharedCatalogueViewModel.responseModel?.data?[indexPath.row].total_files ?? "0"
            cell.sharedByLbl.isHidden = false
            cell.sharedImgView.isHidden = false
            return cell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == catalougeCollView {
            return CGSize(width: 180, height: 110)
        } else {
            return CGSize(width: 180, height: 140)
        }
        
        //return CGSize(width: 180, height: 130)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        
        /* return UIEdgeInsets(top: 10, left: 0, bottom: 5, right: 5)*/ // Leading space for the first cell
        
        let totalCellWidth = 180 * 2 // Two cells per row, each 180 wide
        let totalSpacingWidth = 10 * 1 // One space between two cells
        let horizontalInset = (collectionView.frame.width - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
        return UIEdgeInsets(top: 10, left: horizontalInset, bottom: 10, right: horizontalInset)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10 // Adjust this value to decrease or increase spacing
    }
    
    
}
