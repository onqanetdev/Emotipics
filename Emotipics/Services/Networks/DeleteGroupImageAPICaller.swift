//
//  DeleteGroupImageAPICaller.swift
//  Emotipics
//
//  Created by Onqanet on 05/05/25.
//

import Foundation





class DeleteGroupImageAPICaller {
    static func deleteGroupImageAPICaller(imgID:Int, groupCode: String, CompletionHandler: @escaping(_ result: Result<GroupImageDeleteResModel, NetworkError>) -> Void) {
        
        let urlString = baseURL + APIEndpoint.groupImgDelete.rawValue
        
        let data = KeychainManager.standard.read(service: "com.Emotipics.service", account: "access-token")!
        let accessToken = String(data: data, encoding: .utf8)!
        print("Access Token from delete Group Image Api--->",accessToken)
        
        guard let url = URL(string: urlString) else {
            print("can not able to convert it into URL")
            return
        }
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST" // Set HTTP method to POST
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
    
        
        let requestBody: [String : Any] = [
            "image_id": imgID,
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
               let jsonResponse = try? JSONDecoder().decode(GroupImageDeleteResModel.self, from: data) {
                print("My JSON Response from Delete Group Image ", jsonResponse)
                
                
                if jsonResponse.success == false {
                    print("The Respons from Group Delete Image✅", jsonResponse.message ?? "!")
                    CompletionHandler(.success(jsonResponse))
                } else {
                    print("The success Response is", jsonResponse.message ?? "@")
                    CompletionHandler(.success(jsonResponse))
                }
                
            } else {
                print("UNABLE TO CONVERT IT INTO JSON RESPONSE from  delete group image")
                CompletionHandler(.failure(.canNotParseData))
            }
            
        }.resume()
        
    }
}
