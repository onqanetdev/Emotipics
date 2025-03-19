//
//  GroupDetailViewController.swift
//  Emotipics
//
//  Created by Onqanet on 18/03/25.
//

import UIKit

class GroupDetailViewController: UIViewController {

    
    
    
    @IBOutlet weak var groupIconImgView: UIImageView! {
        didSet {
            groupIconImgView.layer.cornerRadius = 22.5
            groupIconImgView.clipsToBounds = true
        }
    }
    
    @IBOutlet weak var topView: UIView!
    
    
    @IBOutlet weak var scrollViewHeight: NSLayoutConstraint!
    
    
    @IBOutlet weak var tblViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var detailTblView: UITableView!
    
    
    
    
    
    
    
    
    @IBOutlet weak var roundedView: UIView!{
        didSet {
            roundedView.layer.cornerRadius = 35
            
            roundedView.clipsToBounds = true
        }
    }
    
    
    @IBOutlet weak var ContentView: UIView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        detailTblView.dataSource = self
        detailTblView.delegate = self
        detailTblView.register(UINib(nibName: "GroupDetailViewCell", bundle: nil), forCellReuseIdentifier: "DetailChat")
        
        tblViewHeight.constant = 10*300
        scrollViewHeight.constant = tblViewHeight.constant + 50
        
        
        setTableViewBackground()
        setTopViewBackground()
        
    }
    
    //MARK: Setting Background for Table View Background
    func setTableViewBackground() {
        let backgroundImage = UIImage(named: "TableViewBackground") // Use your image name
        let backgroundImageView = UIImageView(image: backgroundImage)
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.frame = detailTblView.bounds
        backgroundImageView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        detailTblView.backgroundView = backgroundImageView
        detailTblView.backgroundColor = .clear
    }
    
    
    
    
    //MARK: Setting Up function for uiview background
    func setTopViewBackground() {
        guard let topView = topView else { return } // Ensure topView is not nil
        
        guard let roundedView = roundedView else { return }
        
        guard let contentView = ContentView else { return }

        let backgroundImage = UIImage(named: "TableViewBackground") // Replace with your image name
        let backgroundImageView = UIImageView(frame: topView.bounds)
        backgroundImageView.image = backgroundImage
        backgroundImageView.contentMode = .scaleAspectFill
        backgroundImageView.clipsToBounds = true
        backgroundImageView.autoresizingMask = [.flexibleWidth, .flexibleHeight] // Adjust on size change
        
        
        
        let roundedBackgroundView = UIImageView(frame: roundedView.bounds)
            roundedBackgroundView.image = backgroundImage
            roundedBackgroundView.contentMode = .scaleAspectFill
            roundedBackgroundView.clipsToBounds = true
            roundedBackgroundView.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        topView.insertSubview(backgroundImageView, at: 0) // Send it to the back
        roundedView.insertSubview(roundedBackgroundView, at: 0)
        contentView.insertSubview(backgroundImageView, at: 0)
    }
    
    
    
    
    
    @IBAction func backToPreViouspage(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
    }
}



extension GroupDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailChat", for: indexPath) as! GroupDetailViewCell
        
        cell.backgroundColor = .clear
         cell.layer.cornerRadius = 25
         cell.clipsToBounds = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
}






