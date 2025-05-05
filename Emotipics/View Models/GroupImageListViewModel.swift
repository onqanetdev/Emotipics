//
//  GroupImageListViewModel.swift
//  Emotipics
//
//  Created by Onqanet on 05/05/25.
//

import Foundation






class GroupImageListViewModel {
    var responseModel: GroupImageListResModel?
    var requestModel: GroupImageListReqModel = GroupImageListReqModel(groupCode: "", offset: "", limit: "")
    
    func groupImageListViewModel(request: GroupImageListReqModel , completion: @escaping(_ result: userDataDefination) -> Void){
        GroupImageListAPICaller.groupImageListAPICaller(limit: request.limit, offset:request.offset,  groupCode: request.groupCode) { [weak self] result in
            switch result {
            case .success(let data):
                self?.responseModel = data
               // print("Data From Group Image List ", data)
                completion(.goAhead)

                
                

                
            case .failure(let error):
                completion(.heyStop)
                DispatchQueue.main.async {
                    AlertView.showAlert("Warning!", message: error.localizedDescription, okTitle: "OK")
                }
            }
        }
    }
}


