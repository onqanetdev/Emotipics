//
//  SharedCatalogueViewController.swift
//  Emotipics
//
//  Created by Onqanet on 13/03/25.
//

import UIKit

class SharedCatalogueViewController: UIViewController {
    
    

    @IBOutlet weak var roundedView: UIView!{
        didSet {
            roundedView.layer.cornerRadius = 35
            roundedView.clipsToBounds = true
        }
    }
    
    
    
//    @IBOutlet weak var segmentControlShared: UIView!
//    
    
    @IBOutlet weak var segmentControlShared: UISegmentedControl!
    
    // table view
    @IBOutlet weak var sharedCollView: UICollectionView!
    
    
    @IBOutlet weak var myCataLogueLbl: UILabel!{
        didSet {
            myCataLogueLbl.font = UIFont(name: textInputStyle.latoBold.rawValue, size: 18)
        }
    }
    
    
    
    @IBOutlet weak var sortByLbl: UILabel!{
        didSet {
            sortByLbl.font = UIFont(name: textInputStyle.latoRegular.rawValue, size: 15)
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
        sharedCollView.dataSource = self
        sharedCollView.delegate = self
        
        sharedCollView.register(UINib(nibName: "EntryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        
        
        addingLayoutOfPages()
        addPlusIcon()
    }
    
    
    
    func addingLayoutOfPages(){
        if let segmentedControl = segmentControlShared {
            
            let whiteBackground = UIImage(color: .white, size: CGSize(width: 1, height: 32))

            let greenBackground = UIImage(named: "SegmentBackground")?.withRenderingMode(.alwaysOriginal)
            let resizableImage = greenBackground?.resizableImage(withCapInsets: UIEdgeInsets.zero, resizingMode: .stretch)
            segmentedControl.setBackgroundImage(whiteBackground, for: .normal, barMetrics: .default)
            segmentedControl.setBackgroundImage( resizableImage, for: .selected, barMetrics: .default)
            // Set up the selected and unselected styles
            let normalTextAttributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor.gray,
                .font: UIFont.systemFont(ofSize: 14)
                
            ]
            
            let selectedTextAttributes: [NSAttributedString.Key: Any] = [
                .foregroundColor: UIColor(red: 0, green: 0.8, blue: 0.8, alpha: 1.0), // Teal color
                .font: UIFont.systemFont(ofSize: 14, weight: .medium)
                
            ]
            
            segmentedControl.setTitleTextAttributes(normalTextAttributes, for: .normal)
            segmentedControl.setTitleTextAttributes(selectedTextAttributes, for: .selected)
            
            // Add the underline indicator for the selected segment
            addUnderlineForSelectedSegment(segmentedControl)
        }
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
    
    
    
    
    
    @IBAction func backToPrevious(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
    }
    
    
    
    
    @IBAction func changingSegments(_ sender: Any) {
        
        UIView.animate(withDuration: 0.3) {
                // Find the underline view
            if let underlineView = (sender as AnyObject).subviews.first(where: { $0.tag == 999 }) {
                let underlineWidth = (sender as AnyObject).frame.width / CGFloat((sender as AnyObject).numberOfSegments)
                let underlineXPosition = CGFloat((sender as AnyObject).selectedSegmentIndex) * underlineWidth
                    underlineView.frame.origin.x = underlineXPosition
                }
            }
            
            // Handle the segment change
        updateContentForSelectedSegment((sender as AnyObject).selectedSegmentIndex)
    }
    
    
    
    
    
    
    
    func addUnderlineForSelectedSegment(_ segmentedControl: UISegmentedControl) {
        // Remove any existing underline
        //segmentedControl.subviews.filter { $0.tag == 999 }.forEach { $0.removeFromSuperview() }
        
        // Create underline view
        let underlineHeight: CGFloat = 4.0
        let underlineWidth: CGFloat = segmentedControl.frame.width / CGFloat(segmentedControl.numberOfSegments)
        let underlineXPosition = CGFloat(segmentedControl.selectedSegmentIndex) * underlineWidth
        
        let underlineView = UIView(frame: CGRect(x: underlineXPosition,
                                              y: segmentedControl.bounds.size.height - underlineHeight,
                                              width: underlineWidth,
                                              height: underlineHeight))
        underlineView.backgroundColor = UIColor(red: 0, green: 0.8, blue: 0.8, alpha: 1.0) // Teal color
        underlineView.tag = 999
        let underlineView2 = UIView(frame: CGRect(x: underlineXPosition,
                                                  y: segmentedControl.bounds.size.height - underlineHeight,
                                                  width: segmentedControl.frame.width,
                                                  height: 4))
        
        underlineView2.backgroundColor = #colorLiteral(red: 0.9058823529, green: 0.9333333333, blue: 0.9607843137, alpha: 1)
        segmentedControl.addSubview(underlineView2)
        segmentedControl.addSubview(underlineView)
    }
    
    func updateContentForSelectedSegment(_ selectedIndex: Int) {
        // This is where you would update your UI based on which segment is selected
        if selectedIndex == 0 {
            // "Shared with me" tab is selected
            // Show files shared with the current user
            loadSharedWithMeContent()
        } else {
            // "Share by Me" tab is selected
            // Show files shared by the current user
            loadShareByMeContent()
        }
    }

    func loadSharedWithMeContent() {
        // Implement your logic to display files shared with the user
        // For example, fetch and display files from your data source
        print("Loading 'Shared with me' content")
    }

    func loadShareByMeContent() {
        // Implement your logic to display files shared by the user
        // For example, fetch and display files from your data source
        print("Loading 'Share by Me' content")
    }
}


// MARK: Section for collection view delegates and datasources
extension SharedCatalogueViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 40
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! EntryCollectionViewCell
    
            cell.layer.cornerRadius = 15
            cell.clipsToBounds = true
        cell.sharedImgView.isHidden = false
        cell.sharedByLbl.isHidden = false
            return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
            return CGSize(width: 180, height: 150)
       
        
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





extension UIImage {
    convenience init(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        color.setFill()
        UIRectFill(CGRect(origin: .zero, size: size))
        let image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        self.init(cgImage: image.cgImage!)
    }
}
