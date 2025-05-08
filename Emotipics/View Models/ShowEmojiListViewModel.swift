//
//  ShowEmojiListViewModel.swift
//  Emotipics
//
//  Created by Onqanet on 07/05/25.
//

import Foundation



class ShowEmojiListViewModel{
    var responseModel: GroupEmojiListResModel?
    
    var requestModel: GroupEmojiListReqModel = GroupEmojiListReqModel(limit: "", offset: "", sort: "", imgId: 0)
    
    func showEmojiListViewModel(request: GroupEmojiListReqModel, completion: @escaping(_ result: userDataDefination) -> Void) {
        ShowEmojiListAPICaller.showEmojiListAPICaller(limit: request.limit, offset: request.offset, sort: request.sort, imgId: request.imgId) { [weak self] result in
            switch result {
            case .success(let data):
                self?.responseModel = data
                completion(.goAhead)
                
            case .failure(let error):
                completion(.heyStop)
                DispatchQueue.main.async {
                    AlertView.showAlert("Warning!", message: "OOPs! Something Went Wrong!", okTitle: "OK")
                }
            }
        }
    }
}
