//
//  CatalogueUserExitViewModel.swift
//  Emotipics
//
//  Created by Onqanet on 28/04/25.
//

import Foundation



class CatalogueUserExitViewModel{
    var responseModel: CatUserExitResModel?
    var requestModel: CatUserExitReqModel = CatUserExitReqModel(catalogeCode: "")

    func catalogueUserExitViewModel(request: CatUserExitReqModel, completion: @escaping(_ result: userDataDefination) -> Void ) {
        CatalogueUserExitAPICaller.catalogueUserExitAPICaller(catalogueCode: request.catalogeCode) { [weak self] result in
            switch result {
            case .success(let data):
                self?.responseModel = data
                
                
                completion(.goAhead)
                
                DispatchQueue.main.async {
                                AlertView.showAlert("Alert!", message: data.message ?? "Something went wrong.", okTitle: "OK")
                            }
                
                
            case .failure(let error):
                completion(.heyStop)
                DispatchQueue.main.async {
                                AlertView.showAlert("Warning!", message: error.localizedDescription, okTitle: "OK")
                            }            }
        }
    }
}

