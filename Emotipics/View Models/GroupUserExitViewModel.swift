//
//  GroupUserExitViewModel.swift
//  Emotipics
//
//  Created by Onqanet on 01/05/25.
//

import Foundation



class GroupUserExitViewModel {
    var responseModel: GroupUserExitResModel?
    var requestModel: GroupUserExitReqModel = GroupUserExitReqModel(groupCode: "")

    func groupUserExitViewModel(request: GroupUserExitReqModel, completion: @escaping(_ result: userDataDefination) -> Void ) {
        UserExitFromGrpAPICaller.userExitFromGrpAPICaller(groupCode: request.groupCode) { [weak self] result in
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

