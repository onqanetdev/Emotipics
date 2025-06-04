//
//  ShareImgDeleteViewModel.swift
//  Emotipics
//
//  Created by Onqanet on 04/06/25.
//

import Foundation


class ShareImgDeleteViewModel {
    
    var responseModel: ShareImgDeleteResModel?
    var requestModel: ShareImgDeleteReqModel = ShareImgDeleteReqModel(sharedId: "")
    
    
    func shareImgDeleteViewModel(request: ShareImgDeleteReqModel, completion: @escaping(_ result: userDataDefination) -> Void) {
        ShareImgDeleteAPICaller.shareImgDeleteAPICaller(shareId: request.sharedId) { [weak self] result in
            switch result {
            case .success(let data):
                self?.responseModel = data
                completion(.goAhead)
                
            case .failure(let error):
                completion(.heyStop)
                DispatchQueue.main.async {
                    AlertView.showAlert("Warning!", message: "OOPs! Something Went Wrong!", okTitle: "OK")
                }
            }
        }
    }
    
    
}








