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
    
    private var floatingBtn: UIView = {
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
    }
    

    
    func updateScrollViewHeight() {
        // Force collectionView layout update
        catalogueCollView.layoutIfNeeded()
        
//        var height:CGFloat = 180 * 13
//        collectionViewHeight.constant = height
//        scrollViewHeight.constant = collectionViewHeight.constant + 50
//        print("The height of collection View", collectionViewHeight.constant)
//        print("The Height of scroll View", scrollViewHeight.constant)
        
        
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
        
        NSLayoutConstraint.activate([
            floatingBtn.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -90),
            floatingBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            floatingBtn.heightAnchor.constraint(equalToConstant: 60),
            floatingBtn.widthAnchor.constraint(equalToConstant: 60)
        ])
        
    }
}


//extension AllCataloguesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 25
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        
//        
//        if isImageCell {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageCataCell", for: indexPath) as!ImageCatalogueViewCell
//            cell.layer.cornerRadius = 15
//            cell.clipsToBounds = true
//            return cell
//        } else {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! EntryCollectionViewCell
//            cell.layer.cornerRadius = 15
//            cell.clipsToBounds = true
//            return cell
//        }
//        
//        
//        // return UICollectionViewCell()
//        
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        
//       // return CGSize(width: 180, height: 140)
//        
//        if isImageCell {
//            return CGSize(width: 180, height: 160)
//        } else {
//            return CGSize(width: 180, height: 140)
//        }
//        
//        //return CGSize(width: 180, height: 130)
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        
//        /* return UIEdgeInsets(top: 10, left: 0, bottom: 5, right: 5)*/ // Leading space for the first cell
//        
//        let totalCellWidth = 180 * 2 // Two cells per row, each 180 wide
//        let totalSpacingWidth = 10 * 1 // One space between two cells
//        let horizontalInset = (collectionView.frame.width - CGFloat(totalCellWidth + totalSpacingWidth)) / 2
//        return UIEdgeInsets(top: 10, left: horizontalInset, bottom: 10, right: horizontalInset)
//    }
//    
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 10 // Adjust this value to decrease or increase spacing
//    }
//    
//    
//}



extension AllCataloguesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    
    
    
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let numberOfItemsPerRow: CGFloat = 2
//        let spacingBetweenCells: CGFloat = 10
//
//        let totalSpacing = (numberOfItemsPerRow - 1) * spacingBetweenCells // Spacing between items
//        let availableWidth = collectionView.bounds.width - totalSpacing - 20 // Subtract section insets (left + right)
//
//        let cellWidth = availableWidth / numberOfItemsPerRow
//        
//        return CGSize(width: cellWidth, height: cellWidth * 1.1) // Adjust height if needed
//    }
//
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 10 // Spacing between items in the same row
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 10 // Vertical spacing between rows
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
//    }
//    
//    // Your existing methods remain the same
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 23
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

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return -4 // Reduce spacing between items
//    }

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








