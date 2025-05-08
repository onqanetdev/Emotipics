//
//  ShowEmojiListPopUp.swift
//  Emotipics
//
//  Created by Onqanet on 08/05/25.
//

import UIKit

class ShowEmojiListPopUp: UIViewController {

    
    
    @IBOutlet weak var showEmojiListView: UIView!{
        didSet {
            showEmojiListView.layer.cornerRadius = 35
            showEmojiListView.clipsToBounds = true
        }
    }
    
    
    
    @IBOutlet weak var emojiListTblView: UITableView!
    
    
    
    
    var allListViewModel: ShowEmojiListViewModel = ShowEmojiListViewModel()
    
    var imageId: Int = 0
    
    var emojiDetails:[ShowGroupEmojiList] = []
    
    
    private var loaderView: ImageLoaderView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        emojiListTblView.delegate = self
        emojiListTblView.dataSource = self
        emojiListTblView.register(UINib(nibName: "ShowEmojiListPopUpTVC", bundle: nil), forCellReuseIdentifier: "EmojiCell")
        
        showEmojiList(imgID: imageId)
        
    }



    @IBAction func dismissView(_ sender: Any) {
        
        self.dismiss(animated: true)
    }
    
    
    func showEmojiList(imgID: Int) {
        allListViewModel.requestModel.limit = "50"
        allListViewModel.requestModel.offset = "1"
        allListViewModel.requestModel.sort = "DESC"
        allListViewModel.requestModel.imgId = imgID
        
        startCustomLoader()
        
        allListViewModel.showEmojiListViewModel(request: allListViewModel.requestModel) { result in
            DispatchQueue.main.async {
                switch result {
                case .goAhead:
                    print("Emoji List Show")

                    if let emojiDetailsFor = self.allListViewModel.responseModel?.data {
                        self.emojiDetails = emojiDetailsFor
                        
                        self.emojiListTblView.reloadData()
                        self.stopCustomLoader()
                    }
                case .heyStop:
                    print("Error loading emoji for image ID \(imgID)")
                    
                }
                
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
        
       
    }
    
    func stopCustomLoader(){
        print("Trying to stop loader:", loaderView != nil)
        loaderView?.stopAnimating()
        loaderView?.removeFromSuperview()
        
        loaderView = nil
    }
}



extension ShowEmojiListPopUp: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emojiDetails.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmojiCell", for: indexPath) as! ShowEmojiListPopUpTVC
        
        cell.emojiLbl.text =  emojiDetails[indexPath.row].emoji_code
        cell.reactorName.text = emojiDetails[indexPath.row].user?.name
        return cell
    }
    
    
}
