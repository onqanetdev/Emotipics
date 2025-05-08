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
    
    
    @IBOutlet weak var shareFilesBtn: UIButton!{
        didSet {
            shareFilesBtn.layer.cornerRadius = 25
            shareFilesBtn.clipsToBounds = true
            shareFilesBtn.layer.borderWidth = 1
            shareFilesBtn.layer.borderColor = #colorLiteral(red: 0, green: 0.1647058824, blue: 0.3450980392, alpha: 1)
            shareFilesBtn.titleLabel?.font = UIFont(name: textInputStyle.latoBold.rawValue, size: 18)
        }
    }
    
    
    @IBOutlet weak var userGroupName: UILabel!{
        didSet{
            userGroupName.font = UIFont(name: textInputStyle.latoBold.rawValue, size: 16)
        }
    }
    
    
    
    @IBOutlet weak var tenUsers: UILabel!{
        didSet {
            tenUsers.font = UIFont(name: textInputStyle.poppinsRegular.rawValue, size: 13)
        }
    }
    
    //Group Image List View Model
    
    let groupImageListViewModel: GroupImageListViewModel = GroupImageListViewModel()
    
    private var loaderView: ImageLoaderView?
    
    var groupCode = ""
    
    var groupImageData:[GroupImageData] = []
    
    var groupDeleteImageViewModel: GroupDeleteImageViewModel = GroupDeleteImageViewModel()
    //Show Emoji
    var showEmojiViewModel:ShowEmojiListViewModel = ShowEmojiListViewModel()
    
    var emojiCollList:[ShowGroupEmojiList] = []
    
    var sampleDict: [String: [ShowGroupEmojiList]] = [:]
    
    var stringEmoji: String = ""
    
    
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
        
        imageListForGroup(groupCode: groupCode)
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        imageListForGroup(groupCode: groupCode)
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
    
    func imageListForGroup(groupCode: String){
        
        groupImageListViewModel.requestModel.groupCode = groupCode
        groupImageListViewModel.requestModel.limit = "50"
        groupImageListViewModel.requestModel.offset = "1"
        
        //activityIndicator.startAnimating()
        startCustomLoader()
        groupImageListViewModel.groupImageListViewModel(request: groupImageListViewModel.requestModel) { result in
            DispatchQueue.main.async { [self] in
                //self.activityIndicator.stopAnimating()
                //self.stopCustomLoader()
                switch result {
                case .goAhead:
                    
                    
                    DispatchQueue.main.async { [weak self] in
                        
                        
                        if let imageGroupData = self?.groupImageListViewModel.responseModel?.data {
                            self?.groupImageData = imageGroupData
                            
                            // MARK: Use DispatchGroup to wait for all emoji requests
                            let dispatchGroup = DispatchGroup()
                            
                            for image in imageGroupData {
                                if let imgID = image.id {
                                    dispatchGroup.enter()
                                    self?.showEmojiListWithCompletion(imgID: imgID) {
                                        dispatchGroup.leave()
                                    }
                                }
                            }

                            dispatchGroup.notify(queue: .main) {
                                print("✅ All emoji requests completed")
                                //self?.detailTblView.reloadData()
                                self?.stopCustomLoader()
                            }
                            
                            self?.tblViewHeight.constant = CGFloat( 300*(imageGroupData.count) + 300)
                            
                            self?.scrollViewHeight.constant = self?.tblViewHeight.constant ?? 100
                            
                            print("scroll view height", self?.scrollViewHeight.constant)
                        } else {
                            self?.detailTblView.isHidden = true
                        }
                        
                        
                        self?.detailTblView.reloadData()
                        
                    } // DispatchQueue Closing
                    
                    
                    
                case .heyStop:
                    print("Error")
                }
            }
        }
    }
    
//    func showEmojiList(imgID: Int){
//        showEmojiViewModel.requestModel.limit = "4"
//        showEmojiViewModel.requestModel.offset = "1"
//        showEmojiViewModel.requestModel.sort = "DESC"
//        showEmojiViewModel.requestModel.imgId = imgID
//        
//       // activityIndicator.startAnimating()
//        startCustomLoader()
//        showEmojiViewModel.showEmojiListViewModel(request: showEmojiViewModel.requestModel) { result in
//            DispatchQueue.main.async {
//                //self.activityIndicator.stopAnimating()
//                self.stopCustomLoader()
//                switch result {
//                case .goAhead:
//                    print("My Emoji List 🤗 View Model Calling....📞")
//                    //table View Reload Data
//                    DispatchQueue.main.async { [self] in
//                        
//                        detailTblView.reloadData()
//                        
//                    }
//                case .heyStop:
//                    print("Error")
//                }
//                
//                
//            }
//            
//            
//        } // view model
//    }
    
    
    func showEmojiListWithCompletion(imgID: Int, completion: @escaping () -> Void) {
        showEmojiViewModel.requestModel.limit = "4"
        showEmojiViewModel.requestModel.offset = "1"
        showEmojiViewModel.requestModel.sort = "DESC"
        showEmojiViewModel.requestModel.imgId = imgID

        showEmojiViewModel.showEmojiListViewModel(request: showEmojiViewModel.requestModel) { result in
            DispatchQueue.main.async {
                switch result {
                case .goAhead:
                    print("Emoji loaded for image ID \(imgID)")
                case .heyStop:
                    print("Error loading emoji for image ID \(imgID)")
                }
                completion()
            }
        }
    }

    
    
    @IBAction func backToPreViouspage(_ sender: Any) {
        
        navigationController?.popViewController(animated: true)
    }
    
    
    
    
    @IBAction func shareFilesBtn(_ sender: Any) {
        
        let webView = WebViewController()
        webView.isGrpPhotoSharing = true
        webView.groupCode = groupCode
        navigationController?.pushViewController(webView, animated: true)
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
    
    
    
    @objc func allReactionList(_ sender: UIButton){
        let indexPath = sender.tag
        let errorPopup = ShowEmojiListPopUp(nibName: "ShowEmojiListPopUp", bundle: nil)
        errorPopup.modalPresentationStyle = .overCurrentContext
        errorPopup.modalTransitionStyle = .crossDissolve
        
        
        if let imageID = groupImageData[indexPath].id {
            errorPopup.imageId = imageID
        }
        
        //errorPopup.delegate = self
        self.present(errorPopup, animated: true)
        
    }
    
    
    @objc func showingImage(_ sender: UIButton){
        let indexpath = sender.tag
        
        let errorPopup = EmojiListViewController(nibName: "EmojiListViewController", bundle: nil)
        errorPopup.modalPresentationStyle = .overCurrentContext
        errorPopup.modalTransitionStyle = .crossDissolve
        //errorPopup.delegate = self
        errorPopup.groupCode = groupCode
        if let imageID = groupImageData[indexpath].id {
            errorPopup.imgId = imageID
        }
        errorPopup.onCompletionOfEmoji = { [weak self] in
            print("Reloading...................")
            self?.imageListForGroup(groupCode: self?.groupCode ?? "0")
            //self.detailTblView.reloadData()
        }
        self.present(errorPopup, animated: true)
        
    }
    
    
    
    @objc func deletingImage(_ sender: UIButton){
        var indexPath = sender.tag
        

        print("My Image Code is", groupImageData[indexPath].id, "My group code is", groupCode  )
        
        guard let imageID = groupImageData[indexPath].id else {
            return
        }
        
        groupDeleteImageViewModel.requestModel.groupCode = groupCode
        groupDeleteImageViewModel.requestModel.imageId = imageID
        
        
        //activityIndicator.startAnimating()
        startCustomLoader()
        groupDeleteImageViewModel.groupDeleteImageViewModel(request: groupDeleteImageViewModel.requestModel) { result in
            DispatchQueue.main.async { [weak self] in
                //self.activityIndicator.stopAnimating()
                self?.stopCustomLoader()
                switch result {
                case .goAhead:
                    
                    
                    DispatchQueue.main.async { [weak self] in
                        
                        
                        if let imageGroupData = self?.groupImageListViewModel.responseModel?.data {
                            self?.groupImageData = imageGroupData
                            
                            self?.tblViewHeight.constant = CGFloat( 300*(imageGroupData.count) + 300)
                            
                            self?.scrollViewHeight.constant = self?.tblViewHeight.constant ?? 100
                            
                            print("scroll view height", self?.scrollViewHeight.constant as Any)
                        } else {
                            self?.detailTblView.isHidden = true
                        }
                        
                        self?.groupImageData.remove(at: indexPath)
                        self?.detailTblView.reloadData()
                        
                    } // DispatchQueue Closing
                    
                    
                    
                case .heyStop:
                    print("Error")
                }
                
                
            }
            
            
        }
        
        
    }
    
}



extension GroupDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Image Count -> ", groupImageData.count)
        return groupImageData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DetailChat", for: indexPath) as! GroupDetailViewCell
        
        cell.backgroundColor = .clear
        cell.layer.cornerRadius = 25
        cell.clipsToBounds = true

        
        if let imagePath = groupImageData[indexPath.row].path,
           let imgName = groupImageData[indexPath.row].img_name,
           let ownerName = groupImageData[indexPath.row].user?.name{
            var fullImage = imagePath + imgName
            
            if let url = URL(string: fullImage) {
                // Optional: show a placeholder image while loading
                cell.partyImageView.image = UIImage(named: "TopBackGround")
                
                URLSession.shared.dataTask(with: url) { data, _, error in
                    guard let data = data, error == nil else {
                        print("Failed to load image from url: \(fullImage)")
                        return
                    }

                    DispatchQueue.main.async { [self] in
                        // Check if cell is still visible
                        if let updateCell = tableView.cellForRow(at: indexPath) as? GroupDetailViewCell {
                            updateCell.partyImageView.image = UIImage(data: data)
                            updateCell.userName.text = ownerName
                        }
//                        cell.allEmojiBtn.setTitle("Hello", for: .normal)
                        
                        if let emojisAre = self.groupImageData[indexPath.row].emoji {
                        for emoji in 0...emojisAre.count - 1 {
                            
                            if let singleEmoji = emojisAre[emoji].emoji_code {
                                //cell.allEmojiBtn.setTitle(singleEmoji, for: .normal)
                                stringEmoji = self.stringEmoji + String(singleEmoji)
                            } else {
                                
                            }
                            
                        }
                    }
                        
                        cell.allEmojiBtn.setTitle(stringEmoji, for: .normal)
                        stringEmoji = ""
                    } // Main thread upgradation
                    
                }.resume()
                
            }
        } else {
            
        }
        
      //  cell.partyImageView.image = UIImage(data: <#T##Data#>)
        
        
        
        cell.deleteBtnAction.tag = indexPath.row
        cell.deleteBtnAction.addTarget(self, action: #selector(deletingImage), for: .touchUpInside)
        
        cell.selectEmojiBtn.tag = indexPath.row
        cell.selectEmojiBtn.addTarget(self, action: #selector(showingImage), for: .touchUpInside)
        

        cell.allEmojiBtn.tag = indexPath.row
        cell.allEmojiBtn.addTarget(self, action: #selector(allReactionList(_:)), for: .touchUpInside)
        
        
//        if let emojisAre = groupImageData[indexPath.row].emoji {
//        for emoji in 0...emojisAre.count - 1 {
//            
//            if let singleEmoji = emojisAre[emoji].emoji_code {
//                cell.allEmojiBtn.setTitle(singleEmoji, for: .normal)
//            } else {
//                
//            }
//            
//        }
//    }
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let updatedImageCode = groupImageData[indexPath.row].id ,
            let emojisAre = groupImageData[indexPath.row].emoji {
            print("the group code is", groupCode)
            print("Upadted Image code -->", updatedImageCode)
            for emoji in 0...emojisAre.count - 1 {
                print("emo is ", emojisAre[emoji].emoji_code)
            }
        }
    }
}






