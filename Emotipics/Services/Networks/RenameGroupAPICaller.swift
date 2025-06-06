//
//  RenameGroupAPICaller.swift
//  Emotipics
//
//  Created by Onqanet on 29/04/25.
//

import Foundation




class RenameGroupAPICaller {
    static func renameGroupAPICaller(grpName: String , grpCode: String, CompletionHandler: @escaping(_ result: Result<GroupRenameResModel, NetworkError>) -> Void){
        
        
        let data = KeychainManager.standard.read(service: "com.Emotipics.service", account: "access-token")!
        let accessToken = String(data: data, encoding: .utf8)!
        print("Access Token--->",accessToken)
        
        
        
        let urlString = baseURL + APIEndpoint.grpRename.rawValue
        guard let url = URL(string: urlString) else {
            print("can not able to convert it into URL")
            return
        }
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST" // Set HTTP method to POST
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
    
        
        let requestBody: [String : Any] = [
            "groupcode": grpCode,
            "groupname": grpName
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
               let jsonResponse = try? JSONDecoder().decode(GroupRenameResModel.self, from: data) {
                print("My JSON Response from Rename Group✅✅✅✅", jsonResponse)
                
                
                if jsonResponse.success == false {
                    CompletionHandler(.success(jsonResponse))
                } else {
                    CompletionHandler(.success(jsonResponse))
                }
                
                
                
            } else {
                print("UNABLE TO CONVERT IT INTO JSON RESPONSE for RenameGroupAPICaller")
                CompletionHandler(.failure(.canNotParseData))
            }
            
        }.resume()
    }
}




