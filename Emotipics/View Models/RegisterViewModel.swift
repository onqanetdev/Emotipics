//
//  RegisterViewModel.swift
//  Emotipics
//
//  Created by Onqanet on 01/04/25.
//

import Foundation



class RegisterViewModel {
    
    var responseModel:RegisterResponseModel?
    var requestModel: RegisterRequestModel = RegisterRequestModel(name: "", email: "", phone: "", password: "")
    
    func registerNewUserViewModel(_ request: RegisterRequestModel, completion: @escaping(_ result: userDataDefination) -> Void) {
        RegisterAPICaller.registerNewUser(request.name,request.email,request.phone,request.password) { [weak self] result in
            switch result {
            case .success(let data):
                self?.responseModel = data
                completion(.goAhead)
            case .failure(let e):
                print("Data recieving Failed", e)
                completion(.heyStop)
                DispatchQueue.main.async {
                    AlertView.showAlert("Warning!!!", message: "Invalid Credentials!!!", okTitle: "OK")
                }
            }
        }
    }
    
    
}


