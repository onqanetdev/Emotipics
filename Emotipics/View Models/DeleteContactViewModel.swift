//
//  DeleteContactViewModel.swift
//  Emotipics
//
//  Created by Onqanet on 07/04/25.
//

import Foundation



class DeleteContactViewModel {
    var responseModel:DeleteContactModel?
    var requestModel: DeleteContactReqModel = DeleteContactReqModel(contactCode: "")
    

    func deleteContact(request: DeleteContactReqModel, completion: @escaping(_ result: userDataDefination) -> Void ) {
        DeleteContactApiCaller.deleteContactApiCaller(contactCode: request.contactCode) { [weak self] result in
            switch result {
            case .success(let data):
                self?.responseModel = data
                completion(.goAhead)
                DispatchQueue.main.async {
                    //AlertView.showAlert("Alert!", message: data.message ?? "ContactsCon", okTitle: "OK")
                }
            case .failure(let error):
                completion(.heyStop)
                DispatchQueue.main.async {
                    AlertView.showAlert("Warning!", message: "OOPs! Something Went Wrong!", okTitle: "OK")
                }
            }
        }
    }
}


