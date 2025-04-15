//
//  CatalogueUserAddViewModel.swift
//  Emotipics
//
//  Created by Onqanet on 14/04/25.
//

import Foundation
import UIKit



class CatalogueUserAddViewModel {
    var responseModel: CatalogueUserAddResModel?
    var requestModel: CatalogueUserAddReqModel = CatalogueUserAddReqModel(catalogcode: "", contact_code: "")
    
    func catalogueUserAddViewModel(request: CatalogueUserAddReqModel,viewController: UIViewController, completion: @escaping(_ result: userDataDefination) -> Void){
        CatalogueUserAddApiCaller.catalogueUserAddApiCaller(catalogCode: request.catalogcode, contactCode: request.contact_code) { [weak self] result in
            switch result {
            case .success(let data):
                self?.responseModel = data
                completion(.goAhead)
//                DispatchQueue.main.async {
//                    AlertView.showAlert("Alert!", message: data.message ?? "User Added", okTitle: "OK")
//                }
                
                
                DispatchQueue.main.async {
                    // 👇 Dismiss first, then show alert
                    viewController.dismiss(animated: true) {
                        AlertView.showAlert("Alert!", message: data.message ?? "User Added", okTitle: "OK")
                    }
                }
                
            case .failure(let error):
                completion(.heyStop)
                DispatchQueue.main.async {
                    AlertView.showAlert("Warning!", message: error.localizedDescription, okTitle: "OK")
                }
            }
        }
    }
}

