//
//  SharingContactListVC.swift
//  Emotipics
//
//  Created by Onqanet on 11/04/25.
//

import UIKit

class SharingContactListVC: UIViewController {

    
    @IBOutlet weak var roundedView: UIView!{
        didSet{
            roundedView.layer.cornerRadius = 30
            roundedView.clipsToBounds = true
        }
    }
    
    
    
    
    @IBOutlet weak var submitBtn: UIButton!{
        didSet{
            submitBtn.layer.cornerRadius = 15
            submitBtn.clipsToBounds = true
        }
    }
    
    
    
    @IBOutlet weak var catalogueNameLbl: UILabel!
    
    
    
    
    @IBOutlet weak var contactListTblView: UITableView!
    
    
  
    var conatactViewModel:AllContactsViewModel = AllContactsViewModel()
    var data:[Datam] = []
    var catalogData:[DataM] = []
    
    var shareIndex = 0
    var selectedContacts:[String] = []
    
//    var activityIndicator: UIActivityIndicatorView = {
//        let indicator = UIActivityIndicatorView(style: .large)
//        indicator.color = .systemOrange
//        indicator.hidesWhenStopped = true
//        return indicator
//    }()
    
    
    var catalogueUserAddViewModel:CatalogueUserAddViewModel = CatalogueUserAddViewModel()
    
    
    private var loaderView: ImageLoaderView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        contactListTblView.dataSource = self
        contactListTblView.delegate = self

        contactListTblView.register(UINib(nibName: "SharingContactListTVC", bundle: nil), forCellReuseIdentifier: "SharingListTVC" )
        
        
       // setupActivityIndicator()
        loadAllContacts()
        selectedContacts = []
//        print("The Catalog data is ", catalogData[shareIndex].)
    }

    
    
    
//    func setupActivityIndicator() {
//        view.addSubview(activityIndicator)
//        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
//        
//        activityIndicator.transform = CGAffineTransform(scaleX: 3.0, y: 3.0)
//        
//        NSLayoutConstraint.activate([
//            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
//        ])
//    }
//    
    
    
    @IBAction func btnAction(_ sender: Any) {
        
        print("Submitted List Will Be", catalogData[shareIndex].catalog_code )
       // print("Selcted Contacts will be", selectedContacts)
        
        let modifiedString = selectedContacts.joined(separator: ",")
        
        print("Modified String: \(modifiedString)")
        
        
        
        //activityIndicator.startAnimating()
        
        if let catalogCode = catalogData[shareIndex].catalog_code{
            
            
            catalogueUserAddViewModel.requestModel.catalogcode = catalogCode
            catalogueUserAddViewModel.requestModel.contact_code = modifiedString
            
            catalogueUserAddViewModel.catalogueUserAddViewModel(request:catalogueUserAddViewModel.requestModel, viewController: self ) { result in
                DispatchQueue.main.async {
                    //self.activityIndicator.stopAnimating()
                    
                    switch result {
                    case .goAhead:
                        print("Success from SharingContactListVC")
                        //table View Reload Data
                        DispatchQueue.main.async {
                            //self.contactsTblView.reloadData()
                           // self.dismiss(animated: true )
                            //self.deleteDelegate?.updateUI()
                        }
                    case .heyStop:
                        print("Error")
                    }
                    
                    
                }
            }
            
           
        } else {
            AlertView.showAlert("Warning!", message: "Catalog Code is not valid", okTitle: "OK")
        }
        
        
        
    }
    
    
    
    @IBAction func backBtnAction(_ sender: Any) {
        
        self.dismiss(animated: true)
        
    }
    
    func loadAllContacts(){
        
       // activityIndicator.startAnimating()
        startCustomLoader()
        conatactViewModel.allContactList { result in
            DispatchQueue.main.async {
             //   self.activityIndicator.stopAnimating()
                self.stopCustomLoader()
                switch result {
                case .goAhead:
             
                    DispatchQueue.main.async {
                        if let latestData = self.conatactViewModel.responseModel?.data {
                            self.data = latestData
                            self.catalogueNameLbl.text = self.catalogData[self.shareIndex].catalog_name
                           // print("The Catalog data is ", self.catalogData[self.shareIndex].catalog_name)
                        } else {
                            AlertView.showAlert("Alert!", message: "There is no data", okTitle: "OK")
                        }
                        self.contactListTblView.reloadData()
                    }
                case .heyStop:
                    print("Error")
                }
                
                
            }
            
            
        }
    }
    
    
    @objc func checkUncheck(_ sender: UIButton){
        if sender.currentBackgroundImage == UIImage(systemName: "square"){
            sender.setBackgroundImage(UIImage(systemName: "checkmark.square"), for: .normal)
            //selectedContacts.append(data[sender.tag].contactcode ?? "No Contacts")
            print("The contact code is", data[sender.tag].contactcode)
            print("The Catalog code is", catalogData[shareIndex].catalog_code)
            print("The Catalog Name is", catalogData[shareIndex].catalog_name)
            print("----------------------------------------------------------")
            
            if let contactCode = data[sender.tag].contactcode {
                selectedContacts.append(contactCode)
                print("✅ Added: \(contactCode)")
            }
            
            
        } else {
            sender.setBackgroundImage(UIImage(systemName: "square"), for: .normal)
            
            if let contactCode = data[sender.tag].contactcode,
               let index = selectedContacts.firstIndex(of: contactCode) {
                selectedContacts.remove(at: index)
                print("❌ Removed: \(contactCode)")
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

extension SharingContactListVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return 10
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SharingListTVC", for: indexPath) as! SharingContactListTVC
        cell.selectionStyle = .none
        //cell.textLabel?.text = "Custom"
        cell.checkboxBtn.tag = indexPath.row
        cell.contactLbl.text = data[indexPath.row].contactdetails?.name
        cell.checkboxBtn.addTarget(self, action: #selector(checkUncheck(_ :)), for: .touchUpInside)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
}



