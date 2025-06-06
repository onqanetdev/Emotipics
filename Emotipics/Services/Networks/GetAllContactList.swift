//
//  GetAllContactList.swift
//  Emotipics
//
//  Created by Onqanet on 04/04/25.
//

import Foundation


class GetAllContactList {
   static func getAllContacts( CompletionHandler: @escaping(_ result: Result<GetContactResponseModel, NetworkError>) -> Void) {
        
        let data = KeychainManager.standard.read(service: "com.Emotipics.service", account: "access-token")!
        let accessToken = String(data: data, encoding: .utf8)!
        print("Access Token from Get All Contact List Api--->",accessToken)
        
        let dataUser = KeychainManager.standard.read(service: "com.Emotipics.service", account: "UUID")!
        let UuidUser = String(data: dataUser, encoding: .utf8)!
        
        
        
        
        let urlString = baseURL + APIEndpoint.userContactList.rawValue
        
        guard let url = URL(string: urlString) else {
            print("Not Able to Convert it into URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST" // Set HTTP method to POST
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
    
        
        let requestBody: [String : Any] = [
            "offset": "1",
            "limit": "10"
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
               let jsonResponse = try? JSONDecoder().decode(GetContactResponseModel.self, from: data) {
                print("My JSON Response is ", jsonResponse)
                
                
                if jsonResponse.success == false {
                   // print("The Respons from", jsonResponse.message ?? "!")
                    CompletionHandler(.success(jsonResponse))
                } else {
                  //  print("The success Response is", jsonResponse.message ?? "@")
                    CompletionHandler(.success(jsonResponse))
                }
                
            } else {
                print("UNABLE TO CONVERT IT INTO JSON RESPONSE for GetAllContactList")
                CompletionHandler(.failure(.canNotParseData))
            }
            
        }.resume()
        
        
    }
}
