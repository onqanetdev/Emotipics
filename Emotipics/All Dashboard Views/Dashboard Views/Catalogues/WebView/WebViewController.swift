//
//  WebViewController.swift
//  Emotipics
//
//  Created by Onqanet on 09/04/25.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKScriptMessageHandler, WKNavigationDelegate {
    
    
    var webView: WKWebView!
    
    var userCode = "584"
    var destinationId = "2898796"
    var destinationType = "image"
    let baseURL = "https://onqanet.net/dev_biltu01/emotipics/mediaupload"
    
    
    let savedCatalogueId = UserDefaults.standard.string(forKey: "catalogueId")
    let savedUserCode = UserDefaults.standard.string(forKey: "userCode")

    var groupCode = ""
    var isGrpPhotoSharing:Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = #colorLiteral(red: 0, green: 0.1647058824, blue: 0.3450980392, alpha: 1)
      //  webView.scrollView.contentInsetAdjustmentBehavior = .never
        setupWebView()
        
        if isGrpPhotoSharing {
            loadWebsiteForGroup()
        } else {
            loadWebsite()
        }
        
        //loadWebsite()
        view.backgroundColor = .white
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        view.backgroundColor = #colorLiteral(red: 0, green: 0.1647058824, blue: 0.3450980392, alpha: 1)
    }
    
    
    private func setupWebView() {

        // 1. Create a content controller
        let contentController = WKUserContentController()
        contentController.add(self, name: "buttonClicked")

        // 2. Inject the fake Android object with JS
        let js = """
        window.Android = {
            onButtonClicked: function() {
                window.webkit.messageHandlers.buttonClicked.postMessage("goBack");
            }
        };
        """
        let userScript = WKUserScript(source: js, injectionTime: .atDocumentStart, forMainFrameOnly: false)
        contentController.addUserScript(userScript)

        // 3. Create the web view config
        let config = WKWebViewConfiguration()
        config.userContentController = contentController

        // 4. Create and add the WKWebView
        webView = WKWebView(frame: .zero, configuration: config)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.navigationDelegate = self
        webView.scrollView.contentInsetAdjustmentBehavior = .never // ✅ important!
        view.addSubview(webView)
        
        
        
        
        NSLayoutConstraint.activate([
//            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.topAnchor.constraint(equalTo: view.topAnchor, constant: 25),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    

    
    
    
    private func loadWebsite() {
        
        guard let userCode = savedUserCode, let catalogueId = savedCatalogueId else {
             print("❌ Missing userCode or catalogueId")
             return
         }
         
         let fullURLString = "\(baseURL)/\(userCode)/\(catalogueId)/0"
         print("🌐 Loading URL:", fullURLString)

         if let url = URL(string: fullURLString) {
             webView.load(URLRequest(url: url))
         } else {
             print("❌ Invalid URL")
         }
        
        
       }
    
    
    
    private func loadWebsiteForGroup(){
        guard let userCode = savedUserCode else {
            return
        }
        
        let fullURLString = "\(baseURL)/\(userCode)/\(groupCode)/1"
        print("🌐 Loading URL:", fullURLString)

        if let url = URL(string: fullURLString) {
            webView.load(URLRequest(url: url))
        } else {
            print("❌ Invalid URL")
        }
        
    }
    

       // Receive JS message
//       func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
//           if message.name == "buttonClicked", let body = message.body as? String, body == "goBack" {
//               navigationController?.popViewController(animated: true)
//           }
//       }
    
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
            if message.name == "buttonClicked", let body = message.body as? String {
                switch body {
                case "goBack":
                    navigationController?.popViewController(animated: true)
                case "openCamera":
                    openCamera()
                default:
                    break
                }
            }
        }

       deinit {
           webView.configuration.userContentController.removeScriptMessageHandler(forName: "buttonClicked")
       }
}




extension WebViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func openCamera() {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            print("❌ Camera not available on this device.")
            return
        }
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        present(imagePicker, animated: true)
    }
    
    // Called when an image is picked
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        if let image = info[.originalImage] as? UIImage {
            print("📷 Captured image: \(image)")
            // You can handle uploading or processing the image here
        }
    }
    
    // Called if user cancels the picker
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
