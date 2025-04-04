//
//  AppDelegate.swift
//  Emotipics
//
//  Created by Onqanet on 03/03/25.
//

import UIKit
import IQKeyboardManagerSwift





@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //Thread.sleep(forTimeInterval: 5.0)
        print(UIFont.familyNames)
        printFonts()
        func printFonts() {
            for familyName in UIFont.familyNames {
                print("\n-- \(familyName) \n")
                for fontName in UIFont.fontNames(forFamilyName: familyName) {
                    print(fontName)
                }
            }
        }
        IQKeyboardManager.shared.isEnabled = true
        IQKeyboardManager.shared.resignOnTouchOutside = true
        
        
        let hasLaunchedBefore = UserDefaults.standard.bool(forKey: "hasLaunchedBefore")
         if !hasLaunchedBefore {
             KeychainManager.standard.delete(service: "com.Emotipics.service", account: "access-token")
             KeychainManager.standard.delete(service: "com.Emotipics.service", account: "UUID")
             print("Deleted Keychain items on first launch")

             UserDefaults.standard.set(true, forKey: "hasLaunchedBefore")
         }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

