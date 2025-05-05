//
//  GroupDeleteImageViewModel.swift
//  Emotipics
//
//  Created by Onqanet on 05/05/25.
//

import Foundation





class GroupDeleteImageViewModel {
    var responseModel: GroupImageDeleteResModel?
    var requestModel: GroupImageDeleteReqModel = GroupImageDeleteReqModel(imageId: 0, groupCode: "")

    func groupDeleteImageViewModel(request: GroupImageDeleteReqModel, completion: @escaping(_ result: userDataDefination) -> Void ) {
        DeleteGroupImageAPICaller.deleteGroupImageAPICaller(imgID: request.imageId, groupCode: request.groupCode) { [weak self] result in
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


