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
