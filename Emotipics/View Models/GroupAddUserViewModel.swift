//
//  GroupAddUserViewModel.swift
//  Emotipics
//
//  Created by Onqanet on 29/04/25.
//

import Foundation




class GroupAddUserViewModel {
    var responseModel: GroupAddUserResModel?
    var requestModel: GroupAddUserReqModel = GroupAddUserReqModel(groupCode: "", contactCode: "")
    
    func groupAddUserViewModel(request: GroupAddUserReqModel, completion: @escaping(_ result: userDataDefination) -> Void ) {
        GroupAddUserAPICaller.groupAddUserAPICaller(contactCode: request.contactCode, grpCode: request.groupCode) { [weak self] result in
            switch result {
            case .success(let data):
                self?.responseModel = data
                
                
                completion(.goAhead)
                
//                DispatchQueue.main.async {
//                    AlertView.showAlert("Alert!", message: data.message ?? "Something went wrong.", okTitle: "OK")
//                }
                
                
            case .failure(let error):
                completion(.heyStop)
                DispatchQueue.main.async {
                    AlertView.showAlert("Warning!", message: error.localizedDescription, okTitle: "OK")
                }            }
        }
    }
}


