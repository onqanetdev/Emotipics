//
//  ImageLoaderView.swift
//  Emotipics
//
//  Created by Onqanet on 17/04/25.
//

import UIKit

class ImageLoaderView: UIView {
    
    private let imageView = UIImageView()
    private let spinnerLayer = CAShapeLayer()
    private let animationKey = "arcRotation"

    private let whiteLayout: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 50
        view.backgroundColor = .white
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupImageView()
        setupArcSpinner()
        setupLayout()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupImageView()
        setupArcSpinner()
        setupLayout()
    }

    private func setupImageView() {
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "LoadingImage") // Your image asset
        whiteLayout.addSubview(imageView)

        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: whiteLayout.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: whiteLayout.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 110),
            imageView.heightAnchor.constraint(equalToConstant: 110),
        ])
    }

    private func setupArcSpinner() {
        //layer.addSublayer(spinnerLayer)
        whiteLayout.layer.addSublayer(spinnerLayer)
    }

    private func setupLayout() {
        addSubview(whiteLayout)
        
        NSLayoutConstraint.activate([
            whiteLayout.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            whiteLayout.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            whiteLayout.widthAnchor.constraint(equalToConstant: 100),
            whiteLayout.heightAnchor.constraint(equalToConstant: 100)
        ])
    }

//    override func layoutSubviews() {
//        super.layoutSubviews()
//        spinnerLayer.frame = bounds
//
//        // Arc around the whiteLayout center
//        let center = CGPoint(x: bounds.midX, y: bounds.midY)
//        let radius: CGFloat = 60 // adjust radius based on design
//
//        let startAngle = -CGFloat.pi / 2
//        let endAngle = startAngle + 1.5 * CGFloat.pi
//
//        let arcPath = UIBezierPath(
//            arcCenter: center,
//            radius: radius,
//            startAngle: startAngle,
//            endAngle: endAngle,
//            clockwise: true
//        )
//
//        spinnerLayer.path = arcPath.cgPath
//        spinnerLayer.strokeColor = UIColor.systemBlue.cgColor
//        spinnerLayer.lineWidth = 10
//        spinnerLayer.fillColor = UIColor.clear.cgColor
//        spinnerLayer.lineCap = .round
//    }

    
    
    
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        spinnerLayer.frame = whiteLayout.bounds
        
        let center = CGPoint(x: whiteLayout.bounds.midX, y: whiteLayout.bounds.midY)
        let radius: CGFloat = 40 // slightly less than half of whiteLayout's size (which is 110)
        
        let startAngle = -CGFloat.pi / 2
        let endAngle = startAngle + 1.5 * CGFloat.pi

        let arcPath = UIBezierPath(
            arcCenter: center,
            radius: radius,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: true
        )

        spinnerLayer.path = arcPath.cgPath
        spinnerLayer.strokeColor = UIColor.systemBlue.cgColor
        spinnerLayer.lineWidth = 6
        spinnerLayer.fillColor = UIColor.clear.cgColor
        spinnerLayer.lineCap = .round
    }

    
    
    
    
    
    // MARK: - Animation Controls

    func startAnimating() {
        guard spinnerLayer.animation(forKey: animationKey) == nil else { return }

        let rotation = CABasicAnimation(keyPath: "transform.rotation")
        rotation.fromValue = 0
        rotation.toValue = 2 * Double.pi
        rotation.duration = 1.0
        rotation.repeatCount = .infinity
        rotation.isRemovedOnCompletion = false

        spinnerLayer.add(rotation, forKey: animationKey)
    }

    func stopAnimating() {
        spinnerLayer.removeAnimation(forKey: animationKey)
    }
}
