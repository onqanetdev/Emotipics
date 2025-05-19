//
//  SessionManager.swift
//  Emotipics
//
//  Created by Onqanet on 01/05/25.
//

import Foundation
import UIKit



class SessionManager {
    static let shared = SessionManager()

    func logoutUser() {
        // 1. Delete from Keychain
        KeychainManager.standard.delete(service: "com.Emotipics.service", account: "access-token")
        KeychainManager.standard.delete(service: "com.Emotipics.service", account: "UUID")

        // 2. Clear UserDefaults
        UserDefaults.standard.removeObject(forKey: "userEmail")
        UserDefaults.standard.removeObject(forKey: "userCode")

        // 3. Navigate to Login Screen
        DispatchQueue.main.async {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let window = windowScene.windows.first else {
                return
            }

            let loginVC = RegisterViewController() // Or instantiate from storyboard if needed
            loginVC.isSomeFieldsHidden = true
            let nav = UINavigationController(rootViewController: loginVC)
            nav.modalPresentationStyle = .fullScreen

            window.rootViewController = nav
            window.makeKeyAndVisible()
        }
        
        
    }
}
