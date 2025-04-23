//
//  ImageCopyOrMoveApiCaller.swift
//  Emotipics
//
//  Created by Onqanet on 21/04/25.
//

import Foundation


class ImageCopyOrMoveApiCaller {
    static func imageCopyOrMoveApiCaller(imageCode: Int, actionType: String, catalogCode: String, imgSize: Int, imgName: String,CompletionHandler: @escaping(_ result: Result<CopyOrMoveImgResModel, NetworkError>) -> Void){
        
        
        let data = KeychainManager.standard.read(service: "com.Emotipics.service", account: "access-token")!
        let accessToken = String(data: data, encoding: .utf8)!
        print("Access Token--->",accessToken)
        
        
        
        let urlString = baseURL + APIEndpoint.imageCopyOrMove.rawValue
        guard let url = URL(string: urlString) else {
            print("can not able to convert it into URL")
            return
        }
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST" // Set HTTP method to POST
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
    
        
        let requestBody: [String : Any] = [
            "imgid": imageCode,
            "actiontype": actionType,
            "catalog_code": catalogCode,
            "img_size": imgSize,
            "img_name": imgName
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
               let jsonResponse = try? JSONDecoder().decode(CopyOrMoveImgResModel.self, from: data) {
                print("My JSON Response for delete Image is", jsonResponse)
                
                
                if jsonResponse.success == false {
                    print("The Respons from", jsonResponse.message)
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
