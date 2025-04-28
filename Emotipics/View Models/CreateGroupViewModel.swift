//
//  CreateGroupViewModel.swift
//  Emotipics
//
//  Created by Onqanet on 28/04/25.
//

import Foundation




class CreateGroupViewModel {
    var responseModel: GroupCreateResModel?
    var requestModel: GroupCreateReqModel = GroupCreateReqModel(groupName: "")
    
    func createGroupViewModel(request: GroupCreateReqModel, completion: @escaping(_ result: userDataDefination) -> Void ) {
        GroupCreateAPICaller.groupCreateAPICaller(groupName: request.groupName) { [weak self] result in
            switch result {
            case .success(let data):
                self?.responseModel = data
                
                
                completion(.goAhead)
                
                DispatchQueue.main.async {
                    AlertView.showAlert("Alert!", message: data.message ?? "Something went wrong.", okTitle: "OK")
                }
                
                
            case .failure(let error):
                completion(.heyStop)
                DispatchQueue.main.async {
                    AlertView.showAlert("Warning!", message: error.localizedDescription, okTitle: "OK")
                }            }
        }
    }
}



