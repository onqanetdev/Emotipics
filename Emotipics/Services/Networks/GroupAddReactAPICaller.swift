//
//  GroupAddReactAPICaller.swift
//  Emotipics
//
//  Created by Onqanet on 06/05/25.
//

import Foundation





class GroupAddReactAPICaller {
    static func groupAddReactAPICaller( groupCode: String, imgId: Int, emojiCode: String,CompletionHandler: @escaping(_ result: Result<AddEmojiReactResModel, NetworkError>) -> Void){
        
        
        let data = KeychainManager.standard.read(service: "com.Emotipics.service", account: "access-token")!
        let accessToken = String(data: data, encoding: .utf8)!
        print("Access Token--->",accessToken)
        
        
        
        let urlString = baseURL + APIEndpoint.addEmoji.rawValue
        guard let url = URL(string: urlString) else {
            print("can not able to convert it into URL")
            return
        }
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST" // Set HTTP method to POST
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
    
        
        let requestBody: [String : Any] = [
            "image_id": imgId,
            "emoji_code": emojiCode,
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
               let jsonResponse = try? JSONDecoder().decode(AddEmojiReactResModel.self, from: data) {
                print("My JSON Response for Add Emoji👌🏽", jsonResponse)
                
                
                if jsonResponse.success == false {
                    print("Add Image Share", jsonResponse.message)
                    CompletionHandler(.success(jsonResponse))
                } else {
                    print("The success Response is", jsonResponse.message)
                    CompletionHandler(.success(jsonResponse))
                }
                
                
                
            } else {
                print("UNABLE TO CONVERT IT INTO JSON RESPONSE")
                CompletionHandler(.failure(.canNotParseData))
            }
            
        }.resume()
    }
}
