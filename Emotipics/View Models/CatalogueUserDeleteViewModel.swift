//
//  CatalogueUserDeleteViewModel.swift
//  Emotipics
//
//  Created by Onqanet on 25/04/25.
//

import Foundation



class CatalogueUserDeleteViewModel {
    var responseModel: CatalogueUserRmResModel?
    var requestModel: CatalogueUserRmReqModel = CatalogueUserRmReqModel(contactCode: 0)

    func catalogueUserDeleteViewModel(request: CatalogueUserRmReqModel, completion: @escaping(_ result: userDataDefination) -> Void ) {
        CatalogueUserRmAPICaller.catalogueUserRmAPICaller(folderConatactCode: request.contactCode) { [weak self] result in
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









