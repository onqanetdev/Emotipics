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
            cell.clipsToBounds = true
            return cell
        } else { // sharedCatalogueCollView
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! EntryCollectionViewCell
//            cell.backgroundColor = .blue // Differentiate visually
            cell.layer.cornerRadius = 25
            cell.clipsToBounds = true
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
