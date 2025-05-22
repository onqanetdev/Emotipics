//
//  TestImagePreviewVC.swift
//  Emotipics
//
//  Created by Onqanet on 21/05/25.
//

import UIKit

class TestImagePreviewVC: UIViewController, UIScrollViewDelegate {
    
    private let scrollView = UIScrollView()
    private var imageViews: [UIImageView] = []
    
    private let imageNames = ["Party", "Picnic", "Birthday", "Wedding"] // Replace with your actual asset names
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        
        setupScrollView()
        setupImages()
        setupSideButtons()
        setupBackButton()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollViewDidZoom(scrollView)
    }

    
    
    
    private func setupScrollView() {
        scrollView.delegate = self
        scrollView.isPagingEnabled = false
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.minimumZoomScale = 1.0
        scrollView.maximumZoomScale = 3.0
        scrollView.backgroundColor = .black
        scrollView.frame = view.bounds
        view.addSubview(scrollView)
    }
    
    private func setupImages() {
        for (index, imageName) in imageNames.enumerated() {
            let imageView = UIImageView()
            imageView.contentMode = .scaleAspectFit
            imageView.image = UIImage(named: imageName)
            imageView.frame = CGRect(x: CGFloat(index) * scrollView.frame.width,
                                     y: 0,
                                     width: scrollView.frame.width,
                                     height: scrollView.frame.height)
            scrollView.addSubview(imageView)
            imageViews.append(imageView)
        }
        
        scrollView.contentSize = CGSize(width: scrollView.frame.width * CGFloat(imageNames.count), height: scrollView.frame.height)
    }
    
    // Only zoom the current imageView
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        let page = Int(scrollView.contentOffset.x / scrollView.frame.width)
        return imageViews[safe: page]
    }
    
    
    
    private func setupBackButton() {
        let backButton = UIButton(type: .system)
        backButton.frame = CGRect(x: 20, y: 50, width: 40, height: 40)
        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backButton.tintColor = .white
        backButton.addTarget(self, action: #selector(didTapBack), for: .touchUpInside)
        view.addSubview(backButton)
    }
    
    @objc private func didTapBack() {
        //dismiss(animated: true, completion: nil)
        self.navigationController?.popViewController(animated: true)
    }
    
    private func setupSideButtons() {
        let buttonImages = ["square.and.arrow.down", "arrow.left.arrow.right","photo.stack" , "square.and.arrow.up", "trash", "square.and.pencil"]
        
        for (index, imageName) in buttonImages.enumerated() {
            let button = UIButton(type: .system)
            button.frame = CGRect(x: view.frame.width - 60, y: 200 + CGFloat(index * 70), width: 50, height: 50)
            button.setImage(UIImage(systemName: imageName), for: .normal)
            button.tintColor = .white
            button.backgroundColor = UIColor.systemBlue.withAlphaComponent(0.8)
            button.layer.cornerRadius = 25
            button.clipsToBounds = true
            button.tag = index
            button.addTarget(self, action: #selector(sideButtonTapped(_:)), for: .touchUpInside)
            view.addSubview(button)
        }
    }
    
    
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        guard let imageView = viewForZooming(in: scrollView) as? UIImageView,
              let image = imageView.image else { return }

        
        if scrollView.zoomScale > 1 {
            let ratioW = imageView.frame.width / image.size.width
            let ratioH = imageView.frame.height / image.size.height
            let ratio = min(ratioW, ratioH)
            
            let newWidth = image.size.width * ratio
            let newHeight = image.size.height * ratio
            
            let conditionLeft = newWidth * scrollView.zoomScale > imageView.frame.width
            let left = 0.5 * (conditionLeft
                              ? newWidth - imageView.frame.width
                              : scrollView.frame.width - scrollView.contentSize.width)
            
            let conditionTop = newHeight * scrollView.zoomScale > imageView.frame.height
            let top = 0.5 * (conditionTop
                             ? newHeight - imageView.frame.height
                             : scrollView.frame.height - scrollView.contentSize.height)
            
            scrollView.contentInset = UIEdgeInsets(top: top, left: left, bottom: top, right: left)
        } else {
            scrollView.contentInset = .zero
        }
    }
    
    
    
    
    
    
    @objc private func sideButtonTapped(_ sender: UIButton) {
        switch sender.tag {
        case 0:
            print("Download tapped")
        case 1:
            print("Share tapped")
        case 2:
            print("Delete tapped")
        case 3:
            print("Edit tapped")
        default:
            break
        }
    }
}





