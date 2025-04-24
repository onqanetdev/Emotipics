//
//  SharedImageByMeViewModel.swift
//  Emotipics
//
//  Created by Onqanet on 24/04/25.
//

import Foundation




class SharedImageByMeViewModel {
    var responseModel: SharedImgResModel?
    var requestModel: SharedImgReqModel = SharedImgReqModel(sharetype: "", usercode: "", limit: "", offset: "")

    func sharedImageByMeViewModel(request: SharedImgReqModel, completion: @escaping(_ result: userDataDefination) -> Void ) {
        ShareImageListAPICaller.shareImageListAPICaller(sharetype: request.sharetype, userCode: request.usercode, limit: request.limit, offset: request.offset) { [weak self] result in
            switch result {
            case .success(let data):
                self?.responseModel = data
                
                
                completion(.goAhead)
                
                DispatchQueue.main.async {
                    // 👇 Dismiss first, then show alert
                   // viewController.dismiss(animated: true) {
                      //  AlertView.showAlert("Alert!", message: data.message ?? "User Added", okTitle: "OK")
                   // }
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



