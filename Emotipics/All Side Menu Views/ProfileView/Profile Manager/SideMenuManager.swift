//
//  SideMenuManager.swift
//  Emotipics
//
//  Created by Onqanet on 21/03/25.
//

import Foundation
import UIKit





class SideMenuManager: NSObject, UIGestureRecognizerDelegate, ProfileViewControllerDelegate {
    
    private var sideMenuViewController: ProfileViewController!
    private var sideMenuRevealWidth: CGFloat = 300
    private var paddingForRotation: CGFloat = 150
    private var sideMenuTrailingConstraint: NSLayoutConstraint!
    private var sideMenuShadowView: UIView!
    private var revealSideMenuOnTop: Bool = true
    private var isExpanded: Bool = false
    private var draggingIsEnabled: Bool = false
    private var panBaseLocation: CGFloat = 0.0
    private weak var parentViewController: UIViewController?
    
    func setup(in viewController: UIViewController) {
        self.parentViewController = viewController
        
        guard let view = viewController.view else { return }
        
        // Setup shadow view
        sideMenuShadowView = UIView(frame: view.bounds)
        sideMenuShadowView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        sideMenuShadowView.backgroundColor = .black
        sideMenuShadowView.alpha = 0.0
        view.addSubview(sideMenuShadowView)
        
        // Setup side menu
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        sideMenuViewController = ProfileViewController()
        sideMenuViewController.delegate = self
        view.addSubview(sideMenuViewController.view)
        viewController.addChild(sideMenuViewController)
        sideMenuViewController.didMove(toParent: viewController)
        
        // Side menu constraints
        sideMenuViewController.view.translatesAutoresizingMaskIntoConstraints = false
        sideMenuTrailingConstraint = sideMenuViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -sideMenuRevealWidth - paddingForRotation)
        sideMenuTrailingConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            sideMenuViewController.view.widthAnchor.constraint(equalToConstant: sideMenuRevealWidth),
            sideMenuViewController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            sideMenuViewController.view.topAnchor.constraint(equalTo: view.topAnchor)
        ])
        
        // Gesture Recognizers
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture))
        tapGestureRecognizer.delegate = self
        view.addGestureRecognizer(tapGestureRecognizer)
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
        panGestureRecognizer.delegate = self
        view.addGestureRecognizer(panGestureRecognizer)
        
        
            sideMenuShadowView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    func toggleSideMenu() {
        sideMenuState(expanded: !isExpanded)
    }
    
    //MARK: Delegate Methods
    
    func didSelectMenuItem() {
            // Close the menu when a row is selected
        print("Hello from Side Menu Manager")
            sideMenuState(expanded: false)
        }
    
    
    @objc private func handleTapGesture(sender: UITapGestureRecognizer) {
        if isExpanded {
            sideMenuState(expanded: false)
        }
    }
    
    @objc private func handlePanGesture(sender: UIPanGestureRecognizer) {
        let position: CGFloat = sender.translation(in: parentViewController?.view).x
        let velocity: CGFloat = sender.velocity(in: parentViewController?.view).x

        switch sender.state {
        case .began:
            draggingIsEnabled = velocity > 0 && !isExpanded || velocity < 0 && isExpanded
            if draggingIsEnabled, abs(velocity) > 550 {
                sideMenuState(expanded: !isExpanded)
                draggingIsEnabled = false
                return
            }
            if revealSideMenuOnTop { panBaseLocation = isExpanded ? sideMenuRevealWidth : 0 }
        case .changed:
            if draggingIsEnabled, let view = parentViewController?.view {
                let xLocation = panBaseLocation + position
                let alpha = min(xLocation / sideMenuRevealWidth, 0.6)
                sideMenuShadowView.alpha = alpha
                if xLocation <= sideMenuRevealWidth {
                    sideMenuTrailingConstraint.constant = xLocation - sideMenuRevealWidth
                }
            }
        case .ended:
            draggingIsEnabled = false
            let shouldExpand = sideMenuTrailingConstraint.constant > -sideMenuRevealWidth * 0.5
            sideMenuState(expanded: shouldExpand)
        default:
            break
        }
    }
    
    public func sideMenuState(expanded: Bool) {
        isExpanded = expanded
        animateSideMenu(targetPosition: expanded ? 0 : -sideMenuRevealWidth - paddingForRotation)
        UIView.animate(withDuration: 0.5) { self.sideMenuShadowView.alpha = expanded ? 0.6 : 0.0 }
    }
    
    private func animateSideMenu(targetPosition: CGFloat) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0, options: .layoutSubviews, animations: {
            self.sideMenuTrailingConstraint.constant = targetPosition
            self.parentViewController?.view.layoutIfNeeded()
        })
    }
}



















