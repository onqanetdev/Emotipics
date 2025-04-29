//
//  GroupDeleteViewModel.swift
//  Emotipics
//
//  Created by Onqanet on 29/04/25.
//

import Foundation




class GroupDeleteViewModel {
    var responseModel: GroupDeleteResModel?
    var requestModel: GroupDeleteReqModel = GroupDeleteReqModel(groupCode: "")
    
    func groupDeleteViewModel(request: GroupDeleteReqModel, completion: @escaping(_ result: userDataDefination) -> Void ) {
        DeleteGroupAPICaller.deleteGroupAPICaller(groupCode: request.groupCode) { [weak self] result in
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






