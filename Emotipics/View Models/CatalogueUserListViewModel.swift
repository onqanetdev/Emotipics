//
//  CatalogueUserListViewModel.swift
//  Emotipics
//
//  Created by Onqanet on 30/04/25.
//

import Foundation



class CatalogueUserListViewModel {
    var responseModel: CatalogueUserListResModel?
    var requestModel: CatalogueUserListReqModel = CatalogueUserListReqModel(catalogueCode: "")
    func catalogueUserListViewModel(request: CatalogueUserListReqModel, completion: @escaping(_ result: userDataDefination) -> Void ) {
        CatalogueUserListAPICaller.catalogueUserListAPICaller(catalogueCode: request.catalogueCode) { [weak self] result in
            switch result {
            case .success(let data):
                self?.responseModel = data
                
                
                completion(.goAhead)
                
//                DispatchQueue.main.async {
//                    AlertView.showAlert("Alert!", message: data.message ?? "Something went wrong.", okTitle: "OK")
//                }
                
                
            case .failure(let error):
                completion(.heyStop)
                DispatchQueue.main.async {
                    AlertView.showAlert("Warning!", message: error.localizedDescription, okTitle: "OK")
                }            }
        }
    }
}





