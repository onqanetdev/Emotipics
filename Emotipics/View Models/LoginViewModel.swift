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
                print("User Logged in Email Id is ", self?.responseModel?.login_data?[0].user?.email)
                
                
                if let userLoggedinEmail = self?.responseModel?.login_data?[0].user?.email {
                    UserDefaults.standard.set(userLoggedinEmail, forKey: "userEmail")
                } else {
                    print("User Not Found")
                }
                
                //Here Need to Save the Access Token
                guard let tokenData = self?.responseModel?.login_data?[0].access_token  else {
                    return
                }
                
                guard let uuid = self?.responseModel?.login_data?[0].user?.uuid else {
                    return
                }
                
                //Here Saving the user token data
                let accessToken = tokenData
                let accessData = Data(accessToken.utf8)
                KeychainManager.standard.save(accessData, service: "com.Emotipics.service", account: "access-token")
                
                print("Here is my access Token After login", accessToken)
                //Here Saving User UUID
                let uuidUser = uuid
                let uuidData = Data(uuidUser.utf8)
                KeychainManager.standard.save(uuidData, service: "com.Emotipics.service", account: "UUID")
                
                
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





