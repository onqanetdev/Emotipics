//
//  DeleteContactApiCaller.swift
//  Emotipics
//
//  Created by Onqanet on 07/04/25.
//

import Foundation


class DeleteContactApiCaller {
    static func deleteContactApiCaller(contactCode: String, CompletionHandler: @escaping(_ result: Result<DeleteContactModel, NetworkError>) -> Void) {
        
        
        let data = KeychainManager.standard.read(service: "com.Emotipics.service", account: "access-token")!
        let accessToken = String(data: data, encoding: .utf8)!
        print("Access Token from ADD Contacts Api--->",accessToken)
        
        
        
        let urlString = baseURL + APIEndpoint.deleteConatct.rawValue
        guard let url = URL(string: urlString) else {
            print("can not able to convert it into URL")
            return
        }
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST" // Set HTTP method to POST
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
    
        
        let requestBody: [String : Any] = [
            "contactcode": contactCode
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
               let jsonResponse = try? JSONDecoder().decode(DeleteContactModel.self, from: data) {
                print("My JSON Response for delete Contact is", jsonResponse)
                
                
                if jsonResponse.success == false {
                    print("The Respons from", jsonResponse.message ?? "!")
                    CompletionHandler(.success(jsonResponse))
                } else {
                    print("The success Response is", jsonResponse.message ?? "@")
                    CompletionHandler(.success(jsonResponse))
                }
                
            } else {
                print("UNABLE TO CONVERT IT INTO JSON RESPONSE")
                CompletionHandler(.failure(.canNotParseData))
            }
            
        }.resume()
    }
    
}
