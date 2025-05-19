//
//  AddContactViewModel.swift
//  Emotipics
//
//  Created by Onqanet on 04/04/25.
//

import Foundation





class AddContactViewModel {
    var responseModel:AddContactResponseModel?
    
    var requestModel:AddContactRequestModel = AddContactRequestModel(email: "")
    
    
    
    func addContactViewModelfunc(request: AddContactRequestModel, completion: @escaping(_ result: userDataDefination) -> Void ) {
        AddContactApiCaller.addContactApiCaller(email: request.email ) { [weak self] result in
            switch result {
            case .success(let data):
                self?.responseModel = data
                completion(.goAhead)
//                DispatchQueue.main.async {
//                    AlertView.showAlert("Alert!", message: data.message ?? "ContactsCon", okTitle: "OK")
//                }
                print("Added to Contact ✅✅✅✅")
            case .failure(let error):
                completion(.heyStop)
                DispatchQueue.main.async {
                    AlertView.showAlert("Warning!", message: "Api Response ", okTitle: "OK")
                }
            }
        }
    }
    
    
}


