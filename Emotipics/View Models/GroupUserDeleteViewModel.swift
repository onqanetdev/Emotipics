//
//  GroupUserDeleteViewModel.swift
//  Emotipics
//
//  Created by Onqanet on 30/04/25.
//

import Foundation




class GroupUserDeleteViewModel {
    var responseModel: GroupUserDeleteResModel?
    var requestModel: GroupUserDeleteReqModel = GroupUserDeleteReqModel(contactId: 0)
    
    func groupUserDeleteViewModel(request: GroupUserDeleteReqModel, completion: @escaping(_ result: userDataDefination) -> Void ) {
        GroupUserDeleteAPICaller.groupUserDeleteAPICaller(groupConatactCode: request.contactId) { [weak self] result in
            switch result {
            case .success(let data):
                self?.responseModel = data
                
                
                completion(.goAhead)
                
                DispatchQueue.main.async {
                    // 👇 Dismiss first, then show alert
                   // viewController.dismiss(animated: true) {
                      //  AlertView.showAlert("Alert!", message: data.message ?? "User Added", okTitle: "OK")
                   // }
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

