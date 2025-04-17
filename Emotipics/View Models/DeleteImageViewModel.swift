//
//  DeleteImageViewModel.swift
//  Emotipics
//
//  Created by Onqanet on 16/04/25.
//

import Foundation



class DeleteImageViewModel {
    var responseModel:DeleteImageResModel?
    var requestModel: DeleteImageReqModel = DeleteImageReqModel(image_id: 0)
    

    func deleteImage(request: DeleteImageReqModel, completion: @escaping(_ result: userDataDefination) -> Void ) {
        DeleteImageApiCaller.deleteImageApiCaller(imageCode: request.image_id) { [weak self] result in
            switch result {
            case .success(let data):
                self?.responseModel = data
                
                
                completion(.goAhead)
                DispatchQueue.main.async {
                    //AlertView.showAlert("Alert!", message: data.message ?? "ContactsCon", okTitle: "OK")
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
