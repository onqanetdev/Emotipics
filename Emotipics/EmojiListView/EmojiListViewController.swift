//
//  EmojiListViewController.swift
//  Emotipics
//
//  Created by Onqanet on 06/05/25.
//

import UIKit

class EmojiListViewController: UIViewController {
    
    
    @IBOutlet weak var backgroundView: UIView!{
        didSet{
            backgroundView.layer.cornerRadius = 20
            backgroundView.clipsToBounds = true
        }
    }
    
    
    
    
    @IBOutlet weak var emojiCollView: UICollectionView!
    
    
    var groupCode = ""
    var imgId = 0
    
    
    
    var addEmojiViewModel: AddEmojiViewModel = AddEmojiViewModel()
    
    private var loaderView: ImageLoaderView?
    
    let emojis = [
        "😊", "😂", "😍", "😎", "😢", "😡", "👍", "💖", "🙌", "🙏", // Basic Emotions and Gestures
        "❤️", "💔", "💯", "✨", "🔥", "🌟", "💫", "🌈", "🍀", "🌻", // Love and Nature
        "🥳", "🤩", "🤔", "🤨", "😱", "😷", "🥴", "😇", "😈", "👻", // Feelings & Reactions
        "🎉", "🎁", "🎶", "🎧", "📱", "💻", "🖥️", "🖱️", "📷", "🖊️", // Objects
        "🍕", "🍔", "🍟", "🌮", "🍣", "🍩", "🍫", "🍻", "🍺", "🥤", // Food and Drink
        "⚽", "🏀", "🏈", "🎾", "🏐", "🏉", "🎳", "🎮", "🎯", "🛹", // Sports & Activities
        "🌍", "🌎", "🌏", "🗺️", "🏙️", "🏞️", "🏖️", "🌄", "⛰️", "🌊", // Nature and Places
        "🚗", "🚌", "🚑", "🚒", "✈️", "🚀", "🚁", "🚂", "🚢", "🛸", // Transportation
        "👩‍⚕️", "👨‍⚕️", "👩‍🏫", "👨‍🏫", "👩‍🔬", "👨‍🔬", "👩‍🍳", "👨‍🍳", "👩‍🎤", "👨‍🎤", // Professions
        "👑", "💎", "🏆", "🥇", "🥈", "🥉", "🏅", "⚖️", "🕰️", "⏳", // Awards & Objects
        "👀", "👂", "👁️", "🧠", "💪", "🦵", "🦴", "👣", "👋", "🖐️", // Body Parts & Movements
        "💄", "💅", "👗", "👠", "👡", "👚", "👕", "👖", "🧢", "🧣", // Clothing
        "🎩", "👑", "👒", "🕶️", "👓", "👑", "💍", "🎽", "🥽", "👕", // Accessories & Fashion
        "🇺🇸", "🇬🇧", "🇨🇦", "🇫🇷", "🇩🇪", "🇮🇹", "🇪🇸", "🇯🇵", "🇰🇷", "🇲🇽", // Country Flags
        "🦄", "🐱", "🐶", "🐹", "🐰", "🐻", "🐼", "🐯", "🐴", "🦁", // Animals
        "🦋", "🐝", "🐞", "🐢", "🦎", "🐍", "🐢", "🦄", "🐉", "🦦", // More Animals
        "👪", "👨‍👩‍👧‍👦", "👩‍👩‍👧", "👨‍👨‍👧‍👦", "🧑‍🤝‍🧑", "👩‍🦳", "👩‍🦰", "👩‍🦱", "👨‍🦳", "👨‍🦰", // Families & Relationships
        "💑", "👩‍❤️‍👨", "👨‍❤️‍👨", "👩‍❤️‍👩", "👨‍👩‍👧", "👨‍👩‍👧‍👦", "👩‍👩‍👧", "👨‍👨‍👧", "👩‍👨‍👧", "👩‍👩‍👧‍👦", // Relationships
        "⚡", "💥", "💨", "💡", "🔥", "🌪️", "🌩️", "🌧️", "🌦️", "🌤️", // Weather
        "🎬", "📽️", "📺", "📷", "🎥", "🎞️", "📺", "📱", "📞", "☎️", // Media & Communication
        "📖", "📚", "📓", "📒", "📘", "📙", "📕", "📗", "📜", "📄", // Books & Documents
        "🎨", "🖌️", "🖍️", "🎭", "🎤", "🎻", "🎷", "🎺", "🎸", "🎼", // Arts & Music
        "🧸", "🎲", "🎯", "🎮", "🎳", "🎤", "🎧", "🎻", "🎼", "🎶" // Entertainment
    ]
    
    var showEmojiViewModel:ShowEmojiListViewModel = ShowEmojiListViewModel()
    
    
    var onCompletionOfEmoji: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // emojiCollView.dataSource = self
        //emojiCollView.delegate = self
        
        emojiCollView.register(EmojiCell.self, forCellWithReuseIdentifier: "EmojiCell")
        emojiCollView.backgroundColor = .white
        emojiCollView.dataSource = self
        emojiCollView.delegate = self
        
        
        backgroundView.addSubview(emojiCollView)
    }
    
    
    
    @IBAction func viewDismiss(_ sender: Any) {
        self.dismiss(animated: true)
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
        
        // Stop and remove after 5 seconds
    }
    
    func stopCustomLoader(){
        print("Trying to stop loader:", loaderView != nil)
        loaderView?.stopAnimating()
        loaderView?.removeFromSuperview()
        loaderView = nil
    }
    
    
    func showEmojiList(imgID: Int){
        showEmojiViewModel.requestModel.limit = "10"
        showEmojiViewModel.requestModel.offset = "1"
        showEmojiViewModel.requestModel.sort = "DESC"
        showEmojiViewModel.requestModel.imgId = imgID
        
        // activityIndicator.startAnimating()
        startCustomLoader()
        showEmojiViewModel.showEmojiListViewModel(request: showEmojiViewModel.requestModel) { result in
            DispatchQueue.main.async {
                //self.activityIndicator.stopAnimating()
                self.stopCustomLoader()
                switch result {
                case .goAhead:
                    print("My Emoji List 🤗 View Model Calling....📞")
                    //table View Reload Data
                    //DispatchQueue.main.async { [self] in
                    
                    // detailTblView.reloadData()
                    
                    // }
                case .heyStop:
                    print("Error")
                }
                
                
            }
            
            
        } // view model
    }
    
}





extension EmojiListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return emojis.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EmojiCell", for: indexPath) as! EmojiCell
        cell.emojiLabel.text = emojis[indexPath.item]
        return cell
    }
}


extension EmojiListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0 // vertical spacing between rows
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left:0, bottom: 0, right: 0) // padding around the section
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemsPerRow: CGFloat = 7
        let padding: CGFloat = 4
        let totalPadding = padding * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - totalPadding
        let itemWidth = floor(availableWidth / itemsPerRow)
        
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected Emoji is ", emojis[indexPath.row])
        print("Selected Image id is ", imgId)
        print("Selected Group code is ", groupCode)
        
        
        
        
        addEmojiViewModel.requestModel.emojiCode = emojis[indexPath.row]
        addEmojiViewModel.requestModel.groupCode = groupCode
        addEmojiViewModel.requestModel.imageId = imgId
        startCustomLoader()
        addEmojiViewModel.addEmojiViewModel(request: addEmojiViewModel.requestModel) { result in
            DispatchQueue.main.async {
                //self.activityIndicator.stopAnimating()
                self.stopCustomLoader()
                switch result {
                case .goAhead:
                    DispatchQueue.main.async { [self] in
                        showEmojiList(imgID: imgId)
                        onCompletionOfEmoji?()
                        self.emojiCollView.reloadData()
                        self.dismiss(animated: true)
                    }
                case .heyStop:
                    print("Error")
                }
                
                
            }
            
            
        }
    }
    
}





