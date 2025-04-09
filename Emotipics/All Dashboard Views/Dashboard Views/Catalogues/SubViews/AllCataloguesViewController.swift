//
//  AllCataloguesViewController.swift
//  Emotipics
//
//  Created by Onqanet on 12/03/25.
//

import UIKit

class AllCataloguesViewController: UIViewController {
    
    
    @IBOutlet weak var backGroundView: UIView! {
        didSet{
            backGroundView.layer.cornerRadius = 25
            backGroundView.clipsToBounds = true
        }
    }
    
    
    @IBOutlet weak var catalogueCollView: UICollectionView!
    
    
    @IBOutlet weak var scrollViewHeight: NSLayoutConstraint!
    
    
    
    @IBOutlet weak var myCatalogueLbl: UILabel!
    
    @IBOutlet weak var sortByLbl: UILabel!
    
    private var floatingBtn: FloatingBtn = {
        let btn = FloatingBtn()
        btn.translatesAutoresizingMaskIntoConstraints = false
        return btn
    }()
    
    
    @IBOutlet weak var myCatalogueSubLbl: UILabel!
    
    
    //Boolean View for registering Cell
    var isImageCell: Bool = false
    
    
    
    //Taking all constraints for all
    
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    
   
    var dynamicHeight: CGFloat = 0
    
    var catalogueListingViewModel:CatalogueListingViewModel = CatalogueListingViewModel()
    
    var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .systemOrange
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        catalogueCollView.dataSource = self
        catalogueCollView.delegate = self
        
        if  isImageCell {
            //print("This is true")
            myCatalogueLbl.text = "Project Files"
            myCatalogueSubLbl.isHidden = false
            catalogueCollView.register(UINib(nibName: "ImageCatalogueViewCell", bundle: nil), forCellWithReuseIdentifier: "ImageCataCell")
        } else {
            catalogueCollView.register(UINib(nibName: "EntryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
            myCatalogueSubLbl.isHidden = true
        }
        
        //        catalogueCollView.register(UINib(nibName: "EntryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        
        
        myCatalogueLbl.font = UIFont(name: textInputStyle.latoBold.rawValue, size: 17)
        sortByLbl.font = UIFont(name: textInputStyle.latoRegular.rawValue, size: 15)
        addPlusIcon()
        
        
        
        updateScrollViewHeight()
        
        
        if isImageCell {
           // print("Hello From ViewDidLoad from Image Cell True")
            
        } else {
            // print("Hello from viewDidload from image cell  false")
        }
        
        setupActivityIndicator()
        reloadAllData()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        reloadAllData()
    }
    
    func reloadAllData(){
        catalogueListingViewModel.requestModel.limit = "10"
        catalogueListingViewModel.requestModel.offset = "1"
        catalogueListingViewModel.requestModel.sort_folder = "DESC"
        catalogueListingViewModel.requestModel.type_of_list = "catalog_lists"
        
        activityIndicator.startAnimating()
        
        catalogueListingViewModel.catalogueListing(request: catalogueListingViewModel.requestModel) { result in
            DispatchQueue.main.async { [self] in
                self.activityIndicator.stopAnimating()
                
                switch result {
                case .goAhead:
                    print("Catalogue View Model from AllCataloguesViewController")
                    //table View Reload Data
                    self.catalogueCollView.reloadData()
//                    var sumHeight = (120 * (catalogueListingViewModel.responseModel?.data?.count ?? 1)) / 2
                    
                    var sumHeight = (Int(dynamicHeight) * (catalogueListingViewModel.responseModel?.data?.count ?? 1)) / 2
                    
                    
                    if let countData = catalogueListingViewModel.responseModel?.data?.count {
                        
                        if countData % 2 == 0{
                            let height:CGFloat = CGFloat(sumHeight)
                            self.collectionViewHeight.constant = height
                            scrollViewHeight.constant = collectionViewHeight.constant + 370
                        } else {
                            let height:CGFloat = CGFloat(sumHeight)
                            self.collectionViewHeight.constant = height + 120
                            scrollViewHeight.constant = collectionViewHeight.constant + 370
                        }
                        
                    } else {
                        
                    }
                    
                    
                    
                case .heyStop:
                    print("Error")
                }
                
                
            }
            
            
        }
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

    
    func updateScrollViewHeight() {
        // Force collectionView layout update
        catalogueCollView.layoutIfNeeded()
        

        
        
        var height:CGFloat = dynamicHeight * 13
        collectionViewHeight.constant = height
        scrollViewHeight.constant = collectionViewHeight.constant + 170
        
        print("The Dynamic height is ", dynamicHeight)
//        print("The height of collection View", collectionViewHeight.constant)
//        print("The Height of scroll View", scrollViewHeight.constant)
        
        
       
    }

    
    
    
    
    @IBAction func backToCatalogue(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
        
    }
    
    func addPlusIcon(){
        // floatingBtn.addSubview(Flo)
        view.addSubview(floatingBtn)
        
        if isImageCell {
            floatingBtn.setTarget(self, action: #selector(addWebView), for: .touchUpInside)
        } else {
            floatingBtn.setTarget(self, action: #selector(addNewCatalogue), for: .touchUpInside)
        }
        
        NSLayoutConstraint.activate([
            floatingBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -90),
            floatingBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            floatingBtn.heightAnchor.constraint(equalToConstant: 60),
            floatingBtn.widthAnchor.constraint(equalToConstant: 60)
        ])
        
    }
    
    
    
    @objc func addWebView() {
        let webView = WebViewController()
        navigationController?.pushViewController(webView, animated: true)
    }
    
    @objc func addNewCatalogue() {
        //AddCatalogueApiCaller.addCatalogueApiCaller(folderName: "Dev2 Catalogue")
        let nextView = AddContactViewController()
        nextView.isCatalogueView = true
        nextView.txtFieldPlaceHolder = "Enter Catalogue Name"
        nextView.addCataText = "Create a Catalogue"
        nextView.createCataTxt = "Create a catalogue and add users to share your"
        nextView.favImgLbl = "favourite images"
        
        navigationController?.pushViewController(nextView, animated: true)
        
    }
}





extension AllCataloguesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

//    
//    // Your existing methods remain the same
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return catalogueListingViewModel.responseModel?.data?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if isImageCell {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCataCell", for: indexPath) as! ImageCatalogueViewCell
            cell.layer.cornerRadius = 15
            cell.clipsToBounds = true
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! EntryCollectionViewCell
            cell.layer.cornerRadius = 15
            cell.clipsToBounds = true
            
            if let data = catalogueListingViewModel.responseModel?.data, indexPath.row < data.count {
                let item = data[indexPath.row]
                cell.projectFilesLbl.text = item.catalog_name ?? "Nil"
                cell.noOfFiles.text = item.total_files ?? "Nil"
                cell.fiveGbLbl.text = item.file_storage ?? "Nil"
            } else {
                // Default values for safety
                cell.projectFilesLbl.text = "No Name"
                cell.noOfFiles.text = "0 Files"
                cell.fiveGbLbl.text = "0 GB"
            }
            
            
            
            return cell
        }
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfItemsPerRow: CGFloat = 2
        let spacingBetweenCells: CGFloat = 10
        let sectionInsets: CGFloat = 10 // Reduced from 20 to avoid width issues

        let totalSpacing = (numberOfItemsPerRow - 1) * spacingBetweenCells + (sectionInsets * 2)
        let availableWidth = collectionView.bounds.width - totalSpacing

        let cellWidth = availableWidth / numberOfItemsPerRow

        
        
                if isImageCell {
                    //print("Image Cell is true")
                    dynamicHeight = cellWidth * 1.0
                    return CGSize(width: max(0, cellWidth), height: cellWidth * 1.0)
                } else {
                    //print("Image cell is false")
                    dynamicHeight = 120
                    return CGSize(width: max(0, cellWidth), height: 120)
                }
        
    }



    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10) // Reduce left & right insets
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if let layout = catalogueCollView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.invalidateLayout() // Ensure the layout updates
        }
    }

    
    
    
    
}








