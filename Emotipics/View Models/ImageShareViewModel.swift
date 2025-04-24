//
//  ImageShareViewModel.swift
//  Emotipics
//
//  Created by Onqanet on 23/04/25.
//

import Foundation
import UIKit





class ImageShareViewModel {
    var responseModel: ShareImageResModel?
    var requestModel: ShareImageReqModel = ShareImageReqModel(image_id: 0, user_code: "")
    

    func imageShareViewModel(request: ShareImageReqModel,viewController: UIViewController, completion: @escaping(_ result: userDataDefination) -> Void ) {
        AddImageShareAPICaller.addImageShareAPICaller(image_id: request.image_id, user_code: request.user_code) { [weak self] result in
            switch result {
            case .success(let data):
                self?.responseModel = data
                
                
                completion(.goAhead)
                
                DispatchQueue.main.async {
                    // 👇 Dismiss first, then show alert
                    viewController.dismiss(animated: true) {
                        AlertView.showAlert("Alert!", message: data.message ?? "User Added", okTitle: "OK")
                    }
                }
                
                
            case .failure(let error):
                completion(.heyStop)
                DispatchQueue.main.async {
                    AlertView.showAlert("Warning!", message: "OOPs! Something Went Wrong!", okTitle: "OK")
                }
            }
        }
    }
}
