//
//  APICaller.swift
//  Emotipics
//
//  Created by Onqanet on 27/03/25.
//

import Foundation






enum NetworkError: Error {
    case urlError
    case canNotParseData
    case invalidCredentials
    
    var errorMessage: String {
            switch self {
            case .urlError:
                return "Invalid URL format."
            case .canNotParseData:
                return "Failed to decode response."
            case .invalidCredentials:
                return "Incorrect email or password."
            }
        }
}


public class APICaller {
    static func getAllProducts(email: String, password: String, CompletionHandler: @escaping ( _ result: Result<LoginResponseModel, NetworkError>) -> Void) {
        
        let urlString = baseURL + APIEndpoint.login.rawValue
    
        //1. converting this string into url
        guard let url = URL(string: urlString) else {
            print("Not able to converting it into URl")
            CompletionHandler(.failure(.urlError))
            return
        }
        
        
        // 2. Create the request object
                var request = URLRequest(url: url)
                request.httpMethod = "POST" // Set HTTP method to POST
                request.setValue("application/json", forHTTPHeaderField: "Content-Type") // Set Content-Type
                
                // 3. Create JSON payload
                let requestBody: [String: Any] = [
                    "email": email,
                    "password": password
                ]
                
                do {
                    request.httpBody = try JSONSerialization.data(withJSONObject: requestBody, options: .prettyPrinted)
                } catch {
                    print("Error encoding request body: \(error.localizedDescription)")
                    return
                }
        
        
        //2. if the URL Conversion is sucessful then converting into URL Session task
        
        URLSession.shared.dataTask(with: request) { dataResponse, urlResponse, error in
        //3. assuming the best case where my error is nil ,
            if error == nil ,
                let data = dataResponse ,
               let jsonResponse = try? JSONDecoder().decode(LoginResponseModel.self, from: data) {
                print("My JSON response is ", jsonResponse)
                if jsonResponse.success == false {
                    CompletionHandler(.failure(.invalidCredentials))
                } else {
                    CompletionHandler(.success(jsonResponse))
                }
            } else {
                print("Not able to decode into json")
                CompletionHandler(.failure(.canNotParseData))
            }
        }.resume()
        
                
        
    }
    
    
//    static func login(email: String, password: String) {
//            let urlString = "https://onqanet.net/dev_biltu01/emotipics/api/login"
//            
//            // 1. Convert string to URL
//            guard let url = URL(string: urlString) else {
//                print("Invalid URL")
//                return
//            }
//            
//            // 2. Create the request object
//            var request = URLRequest(url: url)
//            request.httpMethod = "POST" // Set HTTP method to POST
//            request.setValue("application/json", forHTTPHeaderField: "Content-Type") // Set Content-Type
//            
//            // 3. Create JSON payload
//            let requestBody: [String: Any] = [
//                "email": email,
//                "password": password
//            ]
//            
//            do {
//                request.httpBody = try JSONSerialization.data(withJSONObject: requestBody, options: .prettyPrinted)
//            } catch {
//                print("Error encoding request body: \(error.localizedDescription)")
//                return
//            }
//            
//            // 4. Create and start the network request
//            URLSession.shared.dataTask(with: request) { data, response, error in
//                
////                
////                if let jsonString = String(data: data!, encoding: .utf8) {
////                    print("Raw JSON Response:", jsonString)
////                }
//
//                
//                
//                // Ensure no error occurred
//                if let error = error {
//                    print("Request error: \(error.localizedDescription)")
//                    return
//                }
//                
//                // Ensure we received data
//                guard let data = data else {
//                    print("No data received")
//                    return
//                }
//                
//                // 5. Decode JSON response
//                do {
//                    let jsonResponse = try JSONDecoder().decode(LoginResponseModel.self, from: data)
//                    print("Login successful:", jsonResponse)
//                } catch {
//                    print("Failed to decode JSON:", error.localizedDescription)
//                }
//            }.resume()
//        }
    
    
}
