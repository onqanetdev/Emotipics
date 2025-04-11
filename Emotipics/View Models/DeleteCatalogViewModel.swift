//
//  DeleteCatalogViewModel.swift
//  Emotipics
//
//  Created by Onqanet on 10/04/25.
//

import Foundation


class DeleteCatalogViewModel {
    var responseModel: DeleteCatalogResponseModel?
    var requestModel: DeleteCatalogReqModel = DeleteCatalogReqModel(UUID: "")
    
    
    func deleteCatalogViewModel(request: DeleteCatalogReqModel, completion: @escaping(_ result: userDataDefination) -> Void) {
        CatalogDeleteAPICaller.deleteCatApiCaller(uuid: request.UUID) { [weak self] result in
            switch result {
            case .success(let data):
                self?.responseModel = data
                completion(.goAhead)
                DispatchQueue.main.async {
                    AlertView.showAlert("Alert!", message: data.message ?? "ContactsCon", okTitle: "OK")
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
