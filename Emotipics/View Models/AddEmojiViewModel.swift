//
//  AddEmojiViewModel.swift
//  Emotipics
//
//  Created by Onqanet on 06/05/25.
//

import Foundation



class AddEmojiViewModel{
    var responseModel: AddEmojiReactResModel?
    
    var requestModel: AddEmojiReactReqModel = AddEmojiReactReqModel(imageId: 0, groupCode: "", emojiCode: "")
    
    func addEmojiViewModel(request: AddEmojiReactReqModel, completion: @escaping(_ result: userDataDefination) -> Void) {
        GroupAddReactAPICaller.groupAddReactAPICaller(groupCode: request.groupCode, imgId: request.imageId, emojiCode: request.emojiCode) { [weak self] result in
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


