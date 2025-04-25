//
//  CatalogueRenameViewModel.swift
//  Emotipics
//
//  Created by Onqanet on 25/04/25.
//

import Foundation




class CatalogueRenameViewModel {
    var responseModel: CatalogueRenameResModel?
    var requestModel: CatalogueRenameReqModel = CatalogueRenameReqModel(catUUID: "", newName: "")

    func catalogueRenameViewModel(request: CatalogueRenameReqModel, completion: @escaping(_ result: userDataDefination) -> Void ) {
        CatalogueRenameAPICaller.catalogueRenameAPICaller(catUUID: request.catUUID, newFolderName: request.newName) { [weak self] result in
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





