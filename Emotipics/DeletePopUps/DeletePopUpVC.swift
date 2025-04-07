//
//  DeletePopUpVC.swift
//  Emotipics
//
//  Created by Onqanet on 07/04/25.
//

import UIKit

class DeletePopUpVC: UIViewController {

    
    @IBOutlet weak var shortMenu: UIView!{
        didSet {
            shortMenu.layer.cornerRadius = 25
            shortMenu.clipsToBounds = true
        }
    }
    
    var indexOk: String = ""
    
    var deleteContactViewModel: DeleteContactViewModel = DeleteContactViewModel()
    
    
    var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .systemOrange
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    
    weak var deleteDelegate: UpdateUI?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupActivityIndicator()
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
    
    
    
    @IBAction func deleteContact(_ sender: Any) {
        print("Here the desired Contact contact code", indexOk)
        
        //DeleteContactApiCaller.deleteContactApiCaller(contactCode: indexOk)
        activityIndicator.startAnimating()
        deleteContactViewModel.requestModel.contactCode = indexOk
        deleteContactViewModel.deleteContact(request: deleteContactViewModel.requestModel) { result in
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                
                switch result {
                case .goAhead:
                    print("Success 👍🏽")
                    //table View Reload Data
                    DispatchQueue.main.async {
                        //self.contactsTblView.reloadData()
                        self.dismiss(animated: true )
                        self.deleteDelegate?.updateUI()
                    }
                case .heyStop:
                    print("Error")
                }
                
                
            }
        }
    }
    
    
    
    
    @IBAction func exitDeleteView(_ sender: Any) {
       // print("exits")
        self.dismiss(animated: true)
    }
    
}
