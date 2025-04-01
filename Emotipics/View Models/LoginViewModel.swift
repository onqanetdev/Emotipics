//
//  LoginViewModel.swift
//  Emotipics
//
//  Created by Onqanet on 28/03/25.
//

import Foundation
import UIKit







enum userDataDefination{
    case goAhead
    case heyStop
    
    var errorMessage: String {
        switch self {
        case .goAhead:
            return "Working Fine"
        case .heyStop:
            return "Inavlid Credentials"
            
        }
    }
}



protocol LoginViewModelDelegate: AnyObject {
    func presentPopup()
}









class LoginViewModel {
    var responseModel:LoginResponseModel?
    
    var requestModel:LoginParamsStruct = LoginParamsStruct(email: "", password: "")
    
    
    weak var delegate: LoginViewModelDelegate?
    
    
    func getLoginData(_ request: LoginParamsStruct, completion: @escaping(_ result: userDataDefination) -> Void){
        APICaller.getAllProducts(email: request.email, password: request.password) {  [weak self] result in
            switch result {
            case .success(let data):
                self?.responseModel = data
                print("My Response Model is", self?.responseModel as Any)
                completion(.goAhead)
            case .failure(let error):
                print("Getting Error from View Model", error)
                completion(.heyStop)
                DispatchQueue.main.async {
                    self?.delegate?.presentPopup()

                }
            } //switch result ending
        }
    }
    
    
}





