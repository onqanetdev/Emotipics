//
//  CatalogueListingViewModel.swift
//  Emotipics
//
//  Created by Onqanet on 07/04/25.
//

import Foundation


class CatalogueListingViewModel {
    
    var responseModel:CatalogueListingDataModel?
    var requestModel: CatalogueListingReqModel = CatalogueListingReqModel(limit: "", offset: "", sort_folder: "", type_of_list: "")
    
    func catalogueListing(request: CatalogueListingReqModel, completion: @escaping(_ result: userDataDefination) -> Void ) {
        CatalogueListingApiCaller.catalogueListingCaller(limit: request.limit, offset: request.offset, sortfolder: request.sort_folder, typeOfList: request.type_of_list) { [weak self] result in
            switch result {
            case .success(let data):
                self?.responseModel = data
                print("Data", data)
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
