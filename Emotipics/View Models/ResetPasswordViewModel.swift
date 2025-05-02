//
//  ResetPasswordViewModel.swift
//  Emotipics
//
//  Created by Onqanet on 02/05/25.
//

import Foundation





class ResetPasswordViewModel {
    var responseModel: ResetPasswordResModel?
    var requestModel: ResetPasswordReqModel = ResetPasswordReqModel(email: "", password: "", otp: "")
    
    func resetPasswordViewModel(request: ResetPasswordReqModel, completion: @escaping(_ result: userDataDefination) -> Void ) {
        ResetPasswordAPICaller.resetPasswordAPICaller(userEmail: request.email, userNewPassword: request.password, userOTP: request.otp  ) { [weak self] result in
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


