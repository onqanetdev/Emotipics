//
//  AllContactsViewModel.swift
//  Emotipics
//
//  Created by Onqanet on 04/04/25.
//

import Foundation






class AllContactsViewModel {
    var responseModel:GetContactResponseModel?
    var requestModel:ContactsReqModel = ContactsReqModel(offSet: "")
    
    private var isPaginating: Bool = false
    
    func allContactList(request:ContactsReqModel, completion: @escaping(_ result: userDataDefination) -> Void) {
        GetAllContactList.getAllContacts(offset: request.offSet) { result in
            switch result {
            case .success(let data):
                self.responseModel = data
                completion(.goAhead)
            case .failure(let error):
                completion(.heyStop)
                DispatchQueue.main.async {
                    //print("🌩️🌩️🌩️🌩️🌩️🌩️🌩️🌩️🌩️🌩️🌩️🌩️🌩️")
                    AlertView.showAlert("Alert!", message: "Something Went Wrong", okTitle: "OK")
                }
            }
        }
    }
}


