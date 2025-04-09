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

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupWebView()
        loadWebsite()
    }
    
    private func setupWebView() {
//        webView = WKWebView(frame: .zero)
//        webView.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(webView)
        
        
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
        view.addSubview(webView)
        
        
        
        
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
//    private func loadWebsite() {
//        //let fullURLString = "\(baseURL)/\(userCode)/\(destinationId)/\(destinationType)"
//        let fullURLString = baseURL+"/"+userCode+"/"+destinationId+"/"+"0"
//        
//        if let url = URL(string: fullURLString) {
//            let request = URLRequest(url: url)
//            webView.load(request)
//        }
//    }
//    
    
    
    
    
    private func loadWebsite() {
        
//        let fullURLString = baseURL + "/" + savedUserCode + "/" + savedCatalogueId  + "/" + "0"
//        
//        
//           if let localFile = Bundle.main.url(forResource: "webview", withExtension: "html") {
//               webView.loadFileURL(localFile, allowingReadAccessTo: localFile.deletingLastPathComponent())
//           } else if let url = URL(string: fullURLString) {
//               webView.load(URLRequest(url: url))
//           }
        
        
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

       // Receive JS message
       func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
           if message.name == "buttonClicked", let body = message.body as? String, body == "goBack" {
               navigationController?.popViewController(animated: true)
           }
       }

       deinit {
           webView.configuration.userContentController.removeScriptMessageHandler(forName: "buttonClicked")
       }
}





