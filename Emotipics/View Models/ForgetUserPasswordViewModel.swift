//
//  ForgetUserPasswordViewModel.swift
//  Emotipics
//
//  Created by Onqanet on 01/05/25.
//

import Foundation





class ForgetUserPasswordViewModel {
    var responseModel: ForgetPasswordResModel?
    var requestModel: ForgetPasswordReqModel = ForgetPasswordReqModel(email: "")
    
    func forgetUserPasswordViewModel(request: ForgetPasswordReqModel, completion: @escaping(_ result: userDataDefination) -> Void ) {
        ForgetPasswordAPICaller.forgetPasswordAPICaller(userEmail: request.email) { [weak self] result in
            switch result {
            case .success(let data):
                self?.responseModel = data
                
                
                completion(.goAhead)
                
//                DispatchQueue.main.async {
//                    AlertView.showAlert("Alert!", message: data.message ?? "Something went wrong.", okTitle: "OK")
//                }
                
                
            case .failure(let error):
                completion(.heyStop)
                DispatchQueue.main.async {
                    AlertView.showAlert("Warning!", message: error.localizedDescription, okTitle: "OK")
                }            }
        }
    }
}








