//
//  CatalogueImageListViewModel.swift
//  Emotipics
//
//  Created by Onqanet on 16/04/25.
//

import Foundation




class CatalogueImageListViewModel {
    var responseModel: CatalogueImageListResModel?
    var requestModel: CatalogueImageListReqModel = CatalogueImageListReqModel(limit: "", offset: "", catalog_code: "")
    
    func catalogueImageListViewModel(request: CatalogueImageListReqModel , completion: @escaping(_ result: userDataDefination) -> Void){
        CatalogueImageListApiCaller.catalogueImageListApiCaller(limit: request.limit, offset:request.offset,  catalogCode: request.catalog_code) { [weak self] result in
            switch result {
            case .success(let data):
                self?.responseModel = data
                print("Data From CatalogueListViewModel", data)
                completion(.goAhead)

                
                

                
            case .failure(let error):
                completion(.heyStop)
                DispatchQueue.main.async {
                    AlertView.showAlert("Warning!", message: error.localizedDescription, okTitle: "OK")
                }
            }
        }
    }
}



