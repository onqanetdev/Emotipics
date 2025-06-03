//
//  SharedImageByMeViewModel.swift
//  Emotipics
//
//  Created by Onqanet on 24/04/25.
//

import Foundation
import UIKit




class SharedImageByMeViewModel {
    var responseModel: SharedImgResModel?
    var requestModel: SharedImgReqModel = SharedImgReqModel(sharetype: "", usercode: "", limit: "", offset: "")
    
    

    private var imageCache: [String: UIImage] = [:]
    
    
    func sharedImageByMeViewModel(request: SharedImgReqModel, completion: @escaping(_ result: userDataDefination) -> Void ) {
        ShareImageListAPICaller.shareImageListAPICaller(sharetype: request.sharetype, userCode: request.usercode, limit: request.limit, offset: request.offset) { [weak self] result in
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
    
    

//    func fetchImageURL(for index: Int) -> String? {
//        guard let imgPath = responseModel?.path,
//              let imgName = responseModel?.data?[index].img_name else {
//            return nil
//        }
//        return imgPath + imgName
//    }

    
    
}





extension Array {
    subscript(safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
