//
//  RegOTPVerificationAPICaller.swift
//  Emotipics
//
//  Created by Onqanet on 02/04/25.
//

import Foundation





class RegOTPVerificationAPICaller {
    static func verifyOTP(email:String, otp: String, CompletionHandler: @escaping(_ result: Result<RegistrationOTPModel, NetworkError>) -> Void) {
        //1. Taking the string
        let urlString = baseURL + APIEndpoint.otpVerication.rawValue
        
        // 2. Convert it into URL
        guard let url = URL(string: urlString) else {
            print("Not able to convert it into url")
            CompletionHandler(.failure(.urlError))
            return
        }
        
        //3. Create a request object
        var request = URLRequest(url: url)
        request.httpMethod = "POST" // Set HTTP method to POST
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //4.Request body
        let requestBody: [String : Any]  = [
            "email": email,
            "otp": otp
        ]
        
        //5.Json Serialization
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestBody, options: .prettyPrinted)
        } catch {
            print("Error encoding request body: \(error.localizedDescription)")
            return
        }
        
        //6. Pass the request into the urlsession
        URLSession.shared.dataTask(with: request) { dataResponse, urlResponse, error in
            // 7.Assuming the best case over here where the error is nil
            if error == nil,
               let data = dataResponse,
               let jsonResponse = try? JSONDecoder().decode(RegistrationOTPModel.self, from: data){
                print("My JSON Response is", jsonResponse)
                
                
                if jsonResponse.success == false {
                    CompletionHandler(.failure(.invalidCredentials))
                } else {
                    CompletionHandler(.success(jsonResponse))
                }
                
                
            } else {
                print("UNABLE TO CONVERT IT INTO JSON RESPONSE")
                CompletionHandler(.failure(.canNotParseData))
            }
            
            
            
        }.resume()
        
        
        
    }
}


