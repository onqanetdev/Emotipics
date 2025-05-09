//
//  RegisterAPICaller.swift
//  Emotipics
//
//  Created by Onqanet on 01/04/25.
//

import Foundation


class RegisterAPICaller {
    
    static func registerNewUser(_ name: String, _ email: String, _ phone: String, _ password: String, CompletionHandler: @escaping(_ result: Result<RegisterResponseModel, NetworkError>) -> Void) {
        //1.Taking the string
        let urlString = baseURL + APIEndpoint.register.rawValue
        
        //2.convert it into URL
        
        guard let url = URL(string: urlString) else {
            print("Not Able to convert it into url")
            CompletionHandler(.failure(.urlError))
            return
        }
        
        //3. Create a request object
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST" // Set HTTP method to POST
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        //4. Request Body creation
        
        let requestBody: [String : Any] = [
            "name": name,
            "email": email,
            "phone": phone,
            "password": password
        ]
        
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestBody, options: .prettyPrinted)
        } catch {
            print("Error encoding request body: \(error.localizedDescription)")
            return
        }
        
        
        
        //5.Pass the request into the URLSession
        URLSession.shared.dataTask(with: request) { dataResponse, urlResponse, error in
            //6. Assuming the best case here
            
            if error == nil ,
               let data = dataResponse,
               let jsonResponse = try? JSONDecoder().decode(RegisterResponseModel.self, from: data) {
                print("My JSON Response is ", jsonResponse)
                
                if jsonResponse.success == false {
                    CompletionHandler(.failure(.invalidCredentials))
                } else {
                    CompletionHandler(.success(jsonResponse))
                }
                
            } else {
                print("UNABLE TO CONVERT IT INTO JSON RESPONSE for RegisterAPICaller")
                CompletionHandler(.failure(.canNotParseData))
            }
            
        }.resume()
        
        
        
    }
    
    
    
}
