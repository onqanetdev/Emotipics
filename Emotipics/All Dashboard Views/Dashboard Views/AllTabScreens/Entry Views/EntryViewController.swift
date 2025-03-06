//
//  EntryViewController.swift
//  Emotipics
//
//  Created by Onqanet on 06/03/25.
//

import UIKit
import Charts


class EntryViewController: UIViewController {
    
    
    @IBOutlet weak var rotateBtn: UIButton!
    
    
    @IBOutlet weak var topView: UIView!
    
    
    

    

    @IBOutlet weak var welcomeBackLbl: UILabel!{
        didSet{
            
        }
    }
    
    
    //The Oval Card
    
    @IBOutlet weak var cardView: UIView!{
        didSet{
            cardView.layer.cornerRadius = 25
            cardView.clipsToBounds = true
        }
    }
    
    
    @IBOutlet weak var CatalogueLbl: UILabel!{
        didSet{
            //1. set the font family for the label
            
        }
    }
    
    
    @IBOutlet weak var fileColView: UICollectionView!
    
    
    //MARK: 1500 height of the scroll view
    @IBOutlet weak var contentViewHeight: NSLayoutConstraint!
    
    
    
 //MARK: current Plans Titles
    
    @IBOutlet weak var CurrentPlanView: UIView!{
        didSet{
            //1.Add corner radius
            CurrentPlanView.layer.cornerRadius = 20
            CurrentPlanView.clipsToBounds = true
        }
    }
    
    
    @IBOutlet weak var getMoreLbl: UILabel!
    
    
    
    @IBOutlet weak var priceTagLbl: UILabel!
    
    
    
    
    @IBOutlet weak var viewPlansBtn: UIButton!{
        didSet{
            viewPlansBtn.layer.cornerRadius = 10
            viewPlansBtn.clipsToBounds = true
        }
    }
    
    //MARK: This is my table view
    
    
    /**
     - Basic Indea:
                1. Table Height will be equal to (noOfCells * cellHeight)
                2.If new cell is adding then tableView.ReloadData()
                              call agian (noOfCells * cellHeight)
                3. First a fixed height for scrollview then the time table view height will increase the
                scroll view height will also increase
     */
    
    
    
    @IBOutlet weak var contactsTblView: UITableView!
    
    
    @IBOutlet weak var heightsOfContactsiTblView: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        rotateBtn.transform = CGAffineTransform(rotationAngle: CGFloat.pi / 2)
        fileColView.delegate = self
        fileColView.dataSource = self
        //fileColView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "Cell")
        fileColView.register(UINib(nibName: "EntryCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "Cell")
        
        
        
        
        // Table Views for contact Listing
        contactsTblView.dataSource = self
        contactsTblView.delegate = self
       // contactsTblView.register(UITableViewCell.self, forCellReuseIdentifier: "TableCell")
        contactsTblView.register(UINib(nibName: "EntryTableViewCell", bundle: nil), forCellReuseIdentifier: "TableCell")
       // contactsTblView.isHidden = true
        
        //Manipulating contentViewHeight
        
        contentViewHeight.constant = 850
        heightsOfContactsiTblView.constant = 100
        contentViewHeight.constant += heightsOfContactsiTblView.constant
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    
    
    @IBAction func allCatalogueAction(_ sender: Any) {
        
        navigationController?.pushViewController(ExampleViewController(), animated: true)
        //print("The Navigation is not working")
    }
    
    @IBAction func bellIconAction(_ sender: Any) {
        
        print("This is my bell Icon")
    }
    
    
    @IBAction func viewAllContacts(_ sender: Any) {
        navigationController?.pushViewController(ExampleViewController(), animated: true)
        print("This is my all contacts")
    }
}
