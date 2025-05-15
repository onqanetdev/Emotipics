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
    
    
    
    @IBOutlet weak var scrollView: UIScrollView!
    //Group Image List View Model
    
    let groupImageListViewModel: GroupImageListViewModel = GroupImageListViewModel()
    
    private var loaderView: ImageLoaderView?
    
    var groupCode = ""
    
    var groupImageData:[GroupImageData] = []
    
    var groupDeleteImageViewModel: GroupDeleteImageViewModel = GroupDeleteImageViewModel()
    //Show Emoji
    var showEmojiViewModel:ShowEmojiListViewModel = ShowEmojiListViewModel()
    
    var emojiCollList:[ShowGroupEmojiList] = []
    
    
    
    var stringEmoji: String = ""
    
    
    var groupName = ""
    var groupUsers = ""
    
    
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
        
        
        tenUsers.text = groupUsers
        userGroupName.text = groupName
        
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
    




    
    
    func imageListForGroup(groupCode: String) {
        groupImageListViewModel.requestModel.groupCode = groupCode
        groupImageListViewModel.requestModel.limit = "50"
        groupImageListViewModel.requestModel.offset = "1"

        startCustomLoader()
        
        groupImageListViewModel.groupImageListViewModel(request: groupImageListViewModel.requestModel) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }

                switch result {
                case .goAhead:
                    if let imageGroupData = self.groupImageListViewModel.responseModel?.data {
                        self.groupImageData = imageGroupData
                        

                        print("the group image data ", imageGroupData)
                        
                        self.tblViewHeight.constant = CGFloat(imageGroupData.count * 300) + 300
                        self.scrollViewHeight.constant = self.tblViewHeight.constant
                        self.detailTblView.reloadData()
                        self.stopCustomLoader()

                    } else {
                        self.detailTblView.isHidden = true
                        self.tblViewHeight.constant = 0
                        self.scrollView.isScrollEnabled = false
                        self.stopCustomLoader()
                    }

                case .heyStop:
                    print("❌ Error")
                    self.stopCustomLoader()
                }
            }
        }
    }

    
    
    
    
    
    func showEmojiListWithCompletion(imgID: Int, completion: @escaping () -> Void) {
        showEmojiViewModel.requestModel.limit = "4"
        showEmojiViewModel.requestModel.offset = "1"
        showEmojiViewModel.requestModel.sort = "DESC"
        showEmojiViewModel.requestModel.imgId = imgID

        showEmojiViewModel.showEmojiListViewModel(request: showEmojiViewModel.requestModel) { [weak self] result in
            DispatchQueue.main.async {
                guard self != nil else {
                    completion()
                    return
                }

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
    
    
    
    @objc func downloadingImage(_ sender: UIButton){
        let index = sender.tag
        guard index < groupImageData.count else { return }

        guard let imageUrlString = groupImageData[index].path,
              let imageUrlRemaining = groupImageData[index].img_name,// or whatever the URL property is
                let imageUrl = URL(string: imageUrlString + imageUrlRemaining) else {
            print("Invalid image URL")
            return
        }

        startCustomLoader()
        
        DispatchQueue.global().async {
            if let imageData = try? Data(contentsOf: imageUrl),
               let image = UIImage(data: imageData) {
                
                // Save to Photos
                UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.image(_:didFinishSavingWithError:contextInfo:)), nil)
            } else {
                DispatchQueue.main.async {
                    self.stopCustomLoader()
                    print("Failed to download image")
                }
            }
        }
    }
    
    
    @objc func image(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        DispatchQueue.main.async {
            self.stopCustomLoader()
            if let error = error {
                print("❌ Save error: \(error.localizedDescription)")
            } else {
                print("✅ Image successfully saved to Photos")
            }
        }
    }
    
    
    
    
    @IBAction func detailViewPresent(_ sender: Any) {
        
        let errorPopup = DetailsVCPopUp(nibName: "DetailsVCPopUp", bundle: nil)
        errorPopup.modalPresentationStyle = .overCurrentContext
        errorPopup.modalTransitionStyle = .crossDissolve
        
        //errorPopup.delegate = self
        errorPopup.onCompletion = { [weak self] in
            self?.presentDetailsViewPopUp()
        }
        
        self.present(errorPopup, animated: true)
        
    }
    
    
    
    func presentDetailsViewPopUp() {
        
        guard let responseModel = groupImageListViewModel.responseModel else { return }
        
        let errorPopup = DetailsOfDetailsPopUpVC(nibName: "DetailsOfDetailsPopUpVC", bundle: nil)
        errorPopup.modalPresentationStyle = .overCurrentContext
        errorPopup.modalTransitionStyle = .crossDissolve
        
        guard let  ownerName = groupImageListViewModel.responseModel?.owner,
              let groupName = groupImageListViewModel.responseModel?.groupname,
              let totalUserCount = groupImageListViewModel.responseModel?.member_count,
              let createdDate = groupImageListViewModel.responseModel?.created_date else {
                  return
              }
        
        errorPopup.ownerNameVar = ownerName
        errorPopup.grpNmVar = groupName
        errorPopup.totalUserVar = totalUserCount
        errorPopup.createdDateVar = createdDate
        
        //errorPopup.delegate = self
        self.present(errorPopup, animated: true)
    }

    deinit {
        print("🧹 GroupDetailViewController deinitialized")
        // Set breakpoints here or use Instruments > Leaks
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
                            
                            if emojisAre.count <= 2 && emojisAre.count > 0  {
                                
                                for emoji in 0...emojisAre.count - 1 {
                                    
                                    if let singleEmoji = emojisAre[emoji].emoji_code {
                                        //cell.allEmojiBtn.setTitle(singleEmoji, for: .normal)
                                        stringEmoji = self.stringEmoji + String(singleEmoji)
                                        
                                    }
                                    
                                } // for loop ending
                                
                                cell.allEmojiBtn.setTitle(stringEmoji, for: .normal)
                                stringEmoji = ""
                            }  else if emojisAre.count == 0 {
                                cell.allEmojiBtn.setTitle("", for: .normal)
                                //stringEmoji = ""
                            }
                            
                            
                            
                            else {
                                if let firstEmoji = emojisAre[0].emoji_code,
                                    let secondEmoji = emojisAre[1].emoji_code
                                {
                                    //cell.allEmojiBtn.setTitle(singleEmoji, for: .normal)
                                    stringEmoji =  String(firstEmoji) + String(secondEmoji) + String(emojisAre.count - 2) + "+"
                                    cell.allEmojiBtn.setTitle(stringEmoji, for: .normal)
                                    stringEmoji = ""
                                }
                            }
                            
                            
                        }
                        
                    } // Main thread upgradation
                    
                }.resume()
                
            }
        } else {
            
        }
        
        
        
        
        
        cell.deleteBtnAction.tag = indexPath.row
        cell.deleteBtnAction.addTarget(self, action: #selector(deletingImage), for: .touchUpInside)
        
        cell.selectEmojiBtn.tag = indexPath.row
        cell.selectEmojiBtn.addTarget(self, action: #selector(showingImage), for: .touchUpInside)
        
        
        cell.allEmojiBtn.tag = indexPath.row
        cell.allEmojiBtn.addTarget(self, action: #selector(allReactionList(_:)), for: .touchUpInside)
        
        cell.downLoadBtn.tag = indexPath.row
        cell.downLoadBtn.addTarget(self, action: #selector(downloadingImage(_:)), for: .touchUpInside)
        
        
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






