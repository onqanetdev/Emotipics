//
//  GroupDetailImgCell.swift
//  Emotipics
//
//  Created by Onqanet on 06/06/25.
//

import UIKit

class GroupDetailImgCell: UICollectionViewCell, UIScrollViewDelegate {
    
    static let identifier = "GroupDetailImgCellID"
    
    private let scrollView: UIScrollView = {
        let sv = UIScrollView()
        sv.minimumZoomScale = 1.0
        sv.maximumZoomScale = 3.0
        sv.backgroundColor = .black
        return sv
    }()
    
    public let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        return iv
    }()
    
    // MARK: - Overlay Buttons
    let downloadButton = UIButton(type: .system)
    let shareButton = UIButton(type: .system)
    let deleteButton = UIButton(type: .system)
    
    
    //MARK: - Other Buttons
    let birthdayButton = UIButton(type: .system)
    let copyIconButton = UIButton(type: .system)
   // let moveIconButton = UIButton(type: .system)
    
    
    
    
    var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.color = .systemTeal
        indicator.hidesWhenStopped = true
        return indicator
    }()
    
    
    var isDeleteButtonVisible: Bool = true

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        scrollView.delegate = self
        scrollView.frame = contentView.bounds
        contentView.addSubview(scrollView)
        scrollView.addSubview(imageView)
        
        
        setupOverlayButtons()
        setupActivityIndicator()
    }
    
    
    func setupActivityIndicator() {
        contentView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        scrollView.frame = contentView.bounds
        imageView.frame = scrollView.bounds
        
        let buttonSize: CGFloat = 44
        let spacing: CGFloat = 16
        //let startY = contentView.bounds.height / 2 - (buttonSize * 1.5 + spacing)
        let startY = contentView.bounds.height / 2 - (buttonSize * 2.5 + spacing)
        let rightMargin: CGFloat = 16
        
        downloadButton.frame = CGRect(x: contentView.bounds.width - buttonSize - rightMargin,
                                      y: startY,
                                      width: buttonSize,
                                      height: buttonSize)
        
        shareButton.frame = CGRect(x: downloadButton.frame.origin.x,
                                   y: downloadButton.frame.maxY + spacing,
                                   width: buttonSize,
                                   height: buttonSize)
        
//        deleteButton.frame = CGRect(x: shareButton.frame.origin.x,
//                                    y: shareButton.frame.maxY + spacing,
//                                    width: buttonSize,
//                                    height: buttonSize)
        if isDeleteButtonVisible {
            deleteButton.isHidden = false
            deleteButton.frame = CGRect(x: shareButton.frame.origin.x,
                                        y: shareButton.frame.maxY + spacing,
                                        width: buttonSize,
                                        height: buttonSize)
        } else {
            deleteButton.isHidden = true
            deleteButton.frame = CGRect(x: shareButton.frame.origin.x,
                                        y: shareButton.frame.maxY + 0,
                                        width: buttonSize,
                                        height: 0) // Height zero
        }

        
        //MARK: -  Other Button
        
        birthdayButton.frame = CGRect(x: deleteButton.frame.origin.x,
                                      y: deleteButton.frame.maxY + spacing,
                                      width: buttonSize,
                                      height: buttonSize)
        copyIconButton.frame = CGRect(x: birthdayButton.frame.origin.x,
                                      y: birthdayButton.frame.maxY + spacing,
                                      width: buttonSize,
                                      height: buttonSize)
        

        
    }
    
    func configure(with image: UIImage) {
        imageView.image = image
        scrollView.zoomScale = 1.0 // Reset zoom
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    
    
    private func setupOverlayButtons() {
        //configureButton(downloadButton, systemName: "arrow.down.circle")
        //configureButton(shareButton, systemName: "square.and.arrow.up")
        //configureButton(deleteButton, systemName: "trash")
        
        //MARK: Rest of the Buttons
        
        configureButtonMyButton(birthdayButton, named: "BirthdayIcon")
        configureButtonMyButton(copyIconButton, named: "CopyIcon")
        //configureButtonMyButton(moveIconButton, named: "MoveIcon")
        configureButtonMyButton(shareButton, named: "ShareIcon")
        configureButtonMyButton(deleteButton, named: "DeleteIcon")
        configureButtonMyButton(downloadButton, named: "DownloadIcon")
        
        contentView.addSubview(downloadButton)
        contentView.addSubview(shareButton)
        contentView.addSubview(deleteButton)
        
        //MARK: - Content View add Other buttons
        
        contentView.addSubview(birthdayButton)
        contentView.addSubview(copyIconButton)
       // contentView.addSubview(moveIconButton)
    }
    
    private func configureButton(_ button: UIButton, systemName: String) {
        button.setImage(UIImage(systemName: systemName), for: .normal)
        button.tintColor = .white
        button.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        button.layer.cornerRadius = 22 // Half of 44
        button.clipsToBounds = true
    }
    
    private func configureButtonMyButton(_ button: UIButton, named: String) {
        //button.setImage(UIImage(named: named), for: .normal)
        if let image = UIImage(named: named)?.withRenderingMode(.alwaysTemplate) {
                button.setImage(image, for: .normal)
            }
        button.backgroundColor = UIColor(red: 0/255, green: 42/255, blue: 88/255, alpha: 1)
        button.layer.cornerRadius = 22 // Half of 44
        /*ortIcon.image = UIImage(named: "SortIcon")?.withRenderingMode(.alwaysTemplate)*/
        button.tintColor = UIColor(red: 171/255, green: 210/255, blue: 252/255, alpha: 1)
        button.clipsToBounds = true
    }
}




