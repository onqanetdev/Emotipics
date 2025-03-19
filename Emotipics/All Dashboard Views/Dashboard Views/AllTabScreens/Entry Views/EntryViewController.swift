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
            welcomeBackLbl.font = UIFont(name: "Lato-Bold", size: 18)
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
    
    
    @IBOutlet weak var blueCircle: UIView! {
        didSet {
            blueCircle.layer.cornerRadius = blueCircle.frame.size.width / 2
            blueCircle.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var lightBlueCircle: UIView! {
        didSet {
            lightBlueCircle.layer.cornerRadius = lightBlueCircle.frame.size.width / 2
            lightBlueCircle.clipsToBounds = true
        }
    }
    
    
    //Fonts of  lato-regular
    @IBOutlet weak var totalStorageLbl: UILabel!
    @IBOutlet weak var usedFromLbl: UILabel!
    @IBOutlet weak var viewAllLbl: UIButton!
    @IBOutlet weak var contactsViewAllLbl: UIButton! {
        didSet {
            contactsViewAllLbl.setTitleColor(.black, for: .normal)
        }
    }
    
    //Fonts for lato - bold
    
    @IBOutlet weak var fifteenGbLbl: UILabel!
    @IBOutlet weak var getHundredGbLbl: UILabel!
    
    
    @IBOutlet weak var myContactsLbl: UILabel!
    
    
    
    @IBOutlet weak var photosLbl: UILabel!
    
    @IBOutlet weak var videosLbl: UILabel!
    
    @IBOutlet weak var nineGbLbl: UILabel!
    
    @IBOutlet weak var sixGbLbl: UILabel!
    
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
    

    
    
    @IBOutlet weak var bellIconOutlet: UIButton!{
        didSet {
            bellIconOutlet.layer.cornerRadius = 25
            bellIconOutlet.clipsToBounds = true
        }
    }
    
    
    @IBOutlet weak var moreBtnLbl: UIButton!{
        didSet{
            moreBtnLbl.layer.cornerRadius = 25
            moreBtnLbl.clipsToBounds = true
        }
    }
    
    
    @IBOutlet weak var priceTagImg: UIImageView!
    
    
    @IBOutlet weak var backImgView: UIImageView! {
        didSet {
            backImgView.layer.cornerRadius = 30
            backImgView.clipsToBounds = true
        }
    }
    
    
    
    //Implementing the circular view
    var circularView: Circular!
    
    var collectionHeight:Int = 110
    
    
    
    private var pertentageLbl:UILabel = {
        let label = UILabel()
        label.text = "60%"
        label.font = UIFont(name: "Jost-Medium", size: 20)
        label.textColor = #colorLiteral(red: 0.6705882353, green: 0.8235294118, blue: 0.9843137255, alpha: 1)
        return label
    }()
    
    
    
   
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        view.backgroundColor = .white
        // Setting Ups The font
        
        settingUpFonts()

        
        
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
        //heightsOfContactsiTblView.constant = 100
        heightsOfContactsiTblView.constant = 70
        contentViewHeight.constant += heightsOfContactsiTblView.constant
        pertentageLbl.translatesAutoresizingMaskIntoConstraints = false
        setupCircularView()
        setupPecentageLbl()
       
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBarController?.tabBar.isHidden = false
    }
    
    
    
    
    //MARK: Font Family Settigs
    private func settingUpFonts() {
        //         let inputFont = "Lato-Regular"
                totalStorageLbl.font = UIFont(name: textInputStyle.latoRegular.rawValue, size: 16)
                usedFromLbl.font = UIFont(name: textInputStyle.latoRegular.rawValue, size: 14)
                viewAllLbl.titleLabel?.font = UIFont(name: textInputStyle.latoRegular.rawValue, size: 15)
                contactsViewAllLbl.titleLabel?.font = UIFont(name: textInputStyle.latoRegular.rawValue, size: 17)
                //setting Ups fonts  lato-bold
                fifteenGbLbl.font = UIFont(name: textInputStyle.latoBold.rawValue, size: 28)
                CatalogueLbl.font = UIFont(name: textInputStyle.latoBold.rawValue, size: 17)
                getHundredGbLbl.font = UIFont(name: textInputStyle.latoBold.rawValue, size: 17)
                myContactsLbl.font = UIFont(name: textInputStyle.latoBold.rawValue, size: 17)
                //setting ups for fonts poppins-regular
                photosLbl.font = UIFont(name: textInputStyle.poppinsRegular.rawValue, size: 13)
                videosLbl.font = UIFont(name: textInputStyle.poppinsRegular.rawValue, size: 13)
                nineGbLbl.font = UIFont(name: textInputStyle.poppinsRegular.rawValue, size: 13)
                sixGbLbl.font = UIFont(name: textInputStyle.poppinsRegular.rawValue, size: 13)
                //settings ups for fonts poppins-medium
                
                priceTagLbl.font = UIFont(name: textInputStyle.poppinsMedium.rawValue, size: 13)
                viewPlansBtn.titleLabel?.font = UIFont(name: textInputStyle.poppinsMedium.rawValue, size: 14)
    }
    
    
    //Setting Up the Circular View
    
    private func setupCircularView() {

        let sampleColor:UIColor = #colorLiteral(red: 0.6705882353, green: 0.8235294118, blue: 0.9843137255, alpha: 1)
        let percentages: [Double] = [40.00, 60.00] // Example data percentages
        let colors: [UIColor] = [ sampleColor, .systemBlue] // Example colors
        
        
        circularView = Circular(percentages: percentages, colors: colors)
        circularView.translatesAutoresizingMaskIntoConstraints = false
        
       
        cardView.addSubview(circularView)
        
        
        NSLayoutConstraint.activate([
            circularView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 20),
            circularView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 27),
            circularView.widthAnchor.constraint(equalToConstant: 90),
            circularView.heightAnchor.constraint(equalToConstant: 90)
        ])
    }

    
    private func setupPecentageLbl() {
        //cardView.addSubview(pertentageLbl)
        circularView.addSubview(pertentageLbl)
        
        
        NSLayoutConstraint.activate([
            pertentageLbl.centerXAnchor.constraint(equalTo: circularView.centerXAnchor),
            pertentageLbl.centerYAnchor.constraint(equalTo: circularView.centerYAnchor)
        ])
        
    }
    
    
    
//    private func settinUpPlus() {
//        guard let tabBar = tabBarController?.tabBar else { return }
//        view.addSubview(plusView)
//        NSLayoutConstraint.activate([
//            plusView.bottomAnchor.constraint(equalTo: tabBar.topAnchor, constant: 100),
//            plusView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
//            plusView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 10),
//            plusView.heightAnchor.constraint(equalToConstant: 200)
//            
//        ])
//    }
    
    
    
    @IBAction func allCatalogueAction(_ sender: Any) {
        
        navigationController?.pushViewController(CatalogueViewController(), animated: true)
        //print("The Navigation is not working")
    }
    
    @IBAction func bellIconAction(_ sender: Any) {
        
        print("This is my bell Icon")
    }
    
    
    @IBAction func viewAllContacts(_ sender: Any) {
        navigationController?.pushViewController(ContactsViewController(), animated: true)
        print("This is my all contacts")
    }
    
    
    
    @IBAction func notificationViewAction(_ sender: Any) {
        let notificationView = GroupListViewController()
        notificationView.notificationView = true
       
        navigationController?.pushViewController(notificationView, animated: true)
        
        
    }
    
    
}
