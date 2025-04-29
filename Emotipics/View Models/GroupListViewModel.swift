//
//  GroupListViewModel.swift
//  Emotipics
//
//  Created by Onqanet on 28/04/25.
//

import Foundation





class GroupListViewModel {
    var responseModel: GroupListResModel?
    var requestModel: GroupListReqModel = GroupListReqModel(offset: "", limit: "")
    
    func groupListViewModelFunc(request: GroupListReqModel, completion: @escaping(_ result: userDataDefination) -> Void ) {
        GroupListAPICaller.groupListAPICaller(offset: request.offset, limit: request.limit) { [weak self] result in
            switch result {
            case .success(let data):
                self?.responseModel = data
                completion(.goAhead)
            case .failure(let error):
                completion(.heyStop)
                DispatchQueue.main.async {
                    AlertView.showAlert("Warning!", message: error.localizedDescription, okTitle: "OK")
                }            }
        }
    }
}

