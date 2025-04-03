//
//  OTPViewModel.swift
//  Emotipics
//
//  Created by Onqanet on 02/04/25.
//

import Foundation



class OTPViewModel {
    var responseModel: RegistrationOTPModel?
    var requestModel: RegistrationOTPRequestModel = RegistrationOTPRequestModel(email: "", otp: "")
    
    
    func otpVerification(request: RegistrationOTPRequestModel, completion: @escaping(_ result: userDataDefination) -> Void) {
        RegOTPVerificationAPICaller.verifyOTP(email: request.email, otp: request.otp) {    [weak self] result in
            switch result {
            case .success(let data):
                self?.responseModel = data
                print("My OTP Response after First Registration Access token", self?.responseModel?.login_data?[0].access_token as Any)
                
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
                
                //Here Saving User UUID
                let uuidUser = uuid
                let uuidData = Data(uuidUser.utf8)
                KeychainManager.standard.save(uuidData, service: "com.Emotipics.service", account: "UUID")
                
                
                
                completion(.goAhead)
            case .failure(let e):
                print("Data Receiving Falied", e)
                completion(.heyStop)
                DispatchQueue.main.async {
                    AlertView.showAlert("Warning!", message: "Please Enter a Valid OTP", okTitle: "Ok")
                }
                
            }
        }
        
        
    }
}
