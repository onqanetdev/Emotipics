//
//  AlertView.swift
//  Emotipics
//
//  Created by Onqanet on 28/03/25.
//

import UIKit
import Foundation




class AlertView: NSObject {
    
    static func showAlert(_ title: String, message: String?, okTitle: String, success: @escaping (() -> Void)) {
        if let message = message {
            let alert  = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okActionHandler = { (_: UIAlertAction!) -> Void in
                success()
            }
            let okAction = UIAlertAction(title: okTitle, style: .default, handler: okActionHandler)
            alert.addAction(okAction)
            if let presentedViewController = UIApplication.shared.keyWindow?.rootViewController?.presentedViewController {
                presentedViewController.present(alert, animated: true, completion: nil)
            } else {
                UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
            }
        }
    }

    /*----How to use:
     showAlert("Title", message: "Alert msg", okTitle: "Ok", success: { () in
     debugPrint("alertResponse");
     })
    */
    static func showAlert(_ title: String, message: String, okTitle: String, cancelTitle: String, success: @escaping (() -> Void)) {
        let alert  = UIAlertController(title: title, message: message, preferredStyle: .alert)

        let cancelAction = UIAlertAction(title: cancelTitle, style: .default, handler: nil)
        alert.addAction(cancelAction)

        let okActionHandler = { (_: UIAlertAction!) -> Void in
            success()
        }
        let okAction = UIAlertAction(title: okTitle, style: .default, handler: okActionHandler)
        alert.addAction(okAction)
        if let presentedViewController = UIApplication.shared.keyWindow?.rootViewController?.presentedViewController {
            presentedViewController.present(alert, animated: true, completion: nil)
        } else {
            UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
        }
    }
    /*----How to use:
     showAlert("Title", message: "Alert msg", okTitle: "Ok", cancelTitle: "Cancel", success: { () in
     debugPrint("alertResponse");
     })
     */

    static func showAlert(_ title: String, message: String, okTitle: String) {
        let alert  = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: okTitle, style: .default, handler: nil)
        alert.addAction(okAction)
        if let presentedViewController = UIApplication.shared.keyWindow?.rootViewController?.presentedViewController {
            presentedViewController.present(alert, animated: true, completion: nil)
        } else {
            UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
        }
    }
    
}
