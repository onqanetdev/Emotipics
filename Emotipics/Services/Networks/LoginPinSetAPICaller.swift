//
//  LoginPinSetAPICaller.swift
//  Emotipics
//
//  Created by Onqanet on 03/04/25.
//

import Foundation



class LoginPinSetAPICaller {
    static func userPinSet(pin:String, email:String, CompletionHandler: @escaping(_ result: Result<LoginPinResponseModel, NetworkError>) -> Void){
        
        
        
        
        
       let urlString = baseURL + APIEndpoint.pinSet.rawValue
       
       guard let url = URL(string: urlString) else {
           CompletionHandler(.failure(.urlError))
           return
       }
       
       var request = URLRequest(url: url)
       request.httpMethod = "POST" // Set HTTP method to POST
       request.setValue("application/json", forHTTPHeaderField: "Content-Type")
       
       
       let requestBody: [String : Any]  = [
           "pin": pin,
           "email": email
       ]
       
       
       do {
           request.httpBody = try JSONSerialization.data(withJSONObject: requestBody, options: .prettyPrinted)
       } catch {
           print("Error encoding request body: \(error.localizedDescription)")
           return
       }
       
        
        
        URLSession.shared.dataTask(with: request) { dataResponse, urlResponse, error in
            // 7.Assuming the best case over here where the error is nil
            if error == nil,
               let data = dataResponse,
               let jsonResponse = try? JSONDecoder().decode(LoginPinResponseModel.self, from: data){
                print("JSON Response for Login Pin API Caller -->", jsonResponse)
                
                
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
