//
//  AddBirthdayViewModel.swift
//  Emotipics
//
//  Created by Onqanet on 26/05/25.
//

import Foundation




class AddBirthdayViewModel {
    var responseModel: AddBirthdayResModel?
    
    var requestModel: AddBirthdayReqModel = AddBirthdayReqModel(message: "", user_code: "", image_url: "", notifydate: "")
    
    func addBirthdayViewModel(request: AddBirthdayReqModel, completion: @escaping(_ result: userDataDefination) -> Void) {
        AddBirthdayAPICaller.addFuncBirthdayAPICaller(message: request.message, userCode: request.user_code, imgUrl: request.image_url, notifyDate: request.notifydate) { [weak self] result in
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

