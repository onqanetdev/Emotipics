//
//  AddCatalogueApiCaller.swift
//  Emotipics
//
//  Created by Onqanet on 09/04/25.
//

import Foundation






class AddCatalogueApiCaller {
    static func addCatalogueApiCaller(folderName: String, CompletionHandler: @escaping(_ result: Result<AddCatalogueResponseModel, NetworkError>) -> Void) {
        
        
        let data = KeychainManager.standard.read(service: "com.Emotipics.service", account: "access-token")!
        let accessToken = String(data: data, encoding: .utf8)!
        print("Access Token from ADD Contacts Api--->",accessToken)
        
        
        
        let urlString = baseURL + APIEndpoint.addCatalogue.rawValue
        guard let url = URL(string: urlString) else {
            print("can not able to convert it into URL")
            return
        }
        
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST" // Set HTTP method to POST
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
    
        
        let requestBody: [String : Any] = [
            "folder_name": folderName
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
               let jsonResponse = try? JSONDecoder().decode(AddCatalogueResponseModel.self, from: data) {
                print("My JSON Response for Add New Catalogue-->", jsonResponse)
                
                
                if jsonResponse.success == false {
                    print("The Respons from", jsonResponse.message ?? "!")
                    CompletionHandler(.success(jsonResponse))
                } else {
                    print("The success Response is", jsonResponse.message ?? "@")
                    CompletionHandler(.success(jsonResponse))
                }
                
            } else {
                print("UNABLE TO CONVERT IT INTO JSON RESPONSE for AddCatalogueApiCaller")
                CompletionHandler(.failure(.canNotParseData))
            }
            
        }.resume()
    }
}


