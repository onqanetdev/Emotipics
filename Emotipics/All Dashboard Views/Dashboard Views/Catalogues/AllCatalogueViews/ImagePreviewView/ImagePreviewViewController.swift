//
//  ImagePreviewViewController.swift
//  Emotipics
//
//  Created by Onqanet on 21/05/25.
//

import UIKit

class ImagePreviewViewController: UIViewController, UIScrollViewDelegate {
    
    private let scrollView = UIScrollView()
    private let imageView = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        view.backgroundColor = .black
        
        setupScrollView()
        setupImageView()
        setupSideButtons()
        setupBackButton()
    }
    
//    private func setupScrollView() {
//        scrollView.delegate = self
//        scrollView.minimumZoomScale = 1.0
//        scrollView.maximumZoomScale = 3.0
//        scrollView.backgroundColor = .black
//        scrollView.translatesAutoresizingMaskIntoConstraints = false
//        //scrollView.isScrollEnabled = false
//        view.addSubview(scrollView)
//
//        // Add constraints: center it and set width/height
//        NSLayoutConstraint.activate([
//            scrollView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            scrollView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
//            scrollView.widthAnchor.constraint(equalToConstant: 300),
//            scrollView.heightAnchor.constraint(equalToConstant: 250)
//        ])
//    }
    
    
    
    
    private func setupScrollView() {
            scrollView.delegate = self
            scrollView.minimumZoomScale = 1.0
            scrollView.maximumZoomScale = 3.0
            scrollView.frame = view.bounds
            scrollView.backgroundColor = .black
            view.addSubview(scrollView)
        }
    
    

    private func setupImageView() {
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "Party")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 300),
            imageView.heightAnchor.constraint(equalToConstant: 250)
        ])
    }


    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
//    func scrollViewDidZoom(_ scrollView: UIScrollView) {
//        <#code#>
//    }
    
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        if scrollView.zoomScale > 1 {
            if let image = imageView.image {
                let ratioW = imageView.frame.width / image.size.width
                let ratioH = imageView.frame.height / image.size.height
                let ratio = ratioW < ratioH ? ratioW : ratioH

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
            }
        } else {
            scrollView.contentInset = .zero
        }
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



