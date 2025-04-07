//
//  AllContactsViewModel.swift
//  Emotipics
//
//  Created by Onqanet on 04/04/25.
//

import Foundation






class AllContactsViewModel {
    var responseModel:GetContactResponseModel?
    
    func allContactList(completion: @escaping(_ result: userDataDefination) -> Void) {
        GetAllContactList.getAllContacts { result in
            switch result {
            case .success(let data):
                self.responseModel = data
                completion(.goAhead)
            case .failure(let error):
                completion(.heyStop)
                DispatchQueue.main.async {
                    AlertView.showAlert("Alert!", message: "Something Went Wrong", okTitle: "OK")
                }
            }
        }
    }
}


