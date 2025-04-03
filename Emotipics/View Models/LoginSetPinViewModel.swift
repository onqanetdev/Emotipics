//
//  LoginSetPinViewModel.swift
//  Emotipics
//
//  Created by Onqanet on 03/04/25.
//

import Foundation



class LoginSetPinViewModel {
    var responseModel: LoginPinResponseModel?
    var requestModel:LoginPinRequestModel = LoginPinRequestModel(pin: "", email: "")
    
    
    func loginSetPinNew(request: LoginPinRequestModel, completion: @escaping(_ result: userDataDefination) -> Void) {
        LoginPinSetAPICaller.userPinSet(pin: request.pin, email: request.email) {    [weak self] result in
            switch result {
            case .success(let data):
                self?.responseModel = data
                completion(.goAhead)
            case .failure(let e):
                print("Data Receiving Falied", e)
                completion(.heyStop)
                DispatchQueue.main.async {
                    AlertView.showAlert("Warning!", message: "Please Enter a PIN", okTitle: "Ok")
                }
                
            }
        }
        
        
    }
    
    
}
