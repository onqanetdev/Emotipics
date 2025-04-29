//
//  GroupRenameViewModel.swift
//  Emotipics
//
//  Created by Onqanet on 29/04/25.
//

import Foundation





class GroupRenameViewModel {
    var responseModel: GroupRenameResModel?
    var requestModel: GroupRenameReqModel = GroupRenameReqModel(groupName: "", groupCode: "")
    
    func groupRenameViewModel(request: GroupRenameReqModel, completion: @escaping(_ result: userDataDefination) -> Void ) {
        RenameGroupAPICaller.renameGroupAPICaller(grpName: request.groupName, grpCode: request.groupCode) { [weak self] result in
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


