//
//  ImageCopyOrMoveViewModel.swift
//  Emotipics
//
//  Created by Onqanet on 21/04/25.
//

import Foundation



class ImageCopyOrMoveViewModel {
    var responseModel:CopyOrMoveImgResModel?
    var requestModel: CopyOrMoveReqModel = CopyOrMoveReqModel(actiontype: "", imgid: 0, catalog_code: "", img_size: 0, img_name: "")
    

    func copyOrMoveImg(request: CopyOrMoveReqModel, completion: @escaping(_ result: userDataDefination) -> Void ) {
        ImageCopyOrMoveApiCaller.imageCopyOrMoveApiCaller(imageCode: request.imgid, actionType: request.actiontype, catalogCode: request.catalog_code, imgSize: request.img_size, imgName: request.img_name) { [weak self] result in
            switch result {
            case .success(let data):
                self?.responseModel = data
                
                
                completion(.goAhead)
                DispatchQueue.main.async {
                    //AlertView.showAlert("Alert!", message: data.message ?? "ContactsCon", okTitle: "OK")
                    print("From Copy or move image view model")
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

