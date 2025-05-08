//
//  GroupImageListAPICaller.swift
//  Emotipics
//
//  Created by Onqanet on 05/05/25.
//

import Foundation




class GroupImageListAPICaller {
    static func groupImageListAPICaller(limit:String, offset:String,  groupCode: String, CompletionHandler: @escaping(_ result: Result<GroupImageListResModel, NetworkError>) -> Void) {
        let urlString = baseURL + APIEndpoint.groupImageList.rawValue
        
        let data = KeychainManager.standard.read(service: "com.Emotipics.service", account: "access-token")!
        let accessToken = String(data: data, encoding: .utf8)!
        print("Access Token from ADD Contacts Api--->",accessToken)
        
        guard let url = URL(string: urlString) else {
            print("can not able to convert it into URL")
            return
        }
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST" // Set HTTP method to POST
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
    
        
        let requestBody: [String : Any] = [
            "limit": limit,
            "offset": offset,
            "group_code": groupCode
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
               let jsonResponse = try? JSONDecoder().decode(GroupImageListResModel.self, from: data) {
                print("My JSON Response from Catalogue Image Listing ", jsonResponse)
                
                
                if jsonResponse.success == false {
                    print("The Respons from Group Image List✅", jsonResponse.message ?? "!")
                    CompletionHandler(.success(jsonResponse))
                } else {
                    print("The success Response is", jsonResponse.message ?? "@")
                    CompletionHandler(.success(jsonResponse))
                }
                
            } else {
                print("UNABLE TO CONVERT IT INTO JSON RESPONSE FROM GROUPIMAGE LIST API CALLER")
                CompletionHandler(.failure(.canNotParseData))
            }
            
        }.resume()
        
    }
}


