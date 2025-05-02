//
//  ResetPasswordAPICaller.swift
//  Emotipics
//
//  Created by Onqanet on 02/05/25.
//

import Foundation





class ResetPasswordAPICaller {
    static func resetPasswordAPICaller(userEmail: String, userNewPassword: String , userOTP: String,CompletionHandler: @escaping(_ result: Result<ResetPasswordResModel, NetworkError>) -> Void){
        
        
        
        
        let urlString = baseURL + APIEndpoint.resetPassword.rawValue
        guard let url = URL(string: urlString) else {
            print("can not able to convert it into URL")
            return
        }
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST" // Set HTTP method to POST
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        // request.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
        
        
        let requestBody: [String : Any] = [
            "email": userEmail,
            "password": userNewPassword,
            "otp": userOTP
        ]
        
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestBody, options: .prettyPrinted)
        } catch {
            print("Error encoding request body: \(error.localizedDescription)")
            return
        }
        
        // URL Session
        
        URLSession.shared.dataTask(with: request) { dataResponse, urlResponse, error in
            
            
            if error == nil ,
               let data = dataResponse,
               let jsonResponse = try? JSONDecoder().decode(ResetPasswordResModel.self, from: data) {
                print("My JSON Response from Reset Password✅", jsonResponse)
                
                
                if jsonResponse.success == false {
                    // print("Add Image Share", jsonResponse.message)
                    CompletionHandler(.success(jsonResponse))
                } else {
                    //print("The success Response is", jsonResponse.message)
                    CompletionHandler(.success(jsonResponse))
                }
                
                
                
            } else {
                print("UNABLE TO CONVERT IT INTO JSON RESPONSE")
                CompletionHandler(.failure(.canNotParseData))
            }
            
        }.resume()
    }
}

