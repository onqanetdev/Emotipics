//
//  GroupUserListViewModel.swift
//  Emotipics
//
//  Created by Onqanet on 30/04/25.
//

import Foundation



class GroupUserListViewModel {
    var responseModel: GroupUserListResModel?
    var requestModel: GroupUserListReqModel = GroupUserListReqModel(groupCode: "")
    
    func groupAddUserViewModel(request: GroupUserListReqModel, completion: @escaping(_ result: userDataDefination) -> Void ) {
        GroupUserListAPICaller.groupUserListAPICaller(groupCode: request.groupCode) { [weak self] result in
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



