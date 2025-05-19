//
//  AddCatalogueViewModel.swift
//  Emotipics
//
//  Created by Onqanet on 09/04/25.
//

import Foundation



class AddCatalogueViewModel {
    var responseModel: AddCatalogueResponseModel?
    
    var requestModel: AddCatalogueRqModel = AddCatalogueRqModel(folder_name: "")
    
    func addCatalogueVM(request: AddCatalogueRqModel, completion: @escaping(_ result: userDataDefination) -> Void) {
        AddCatalogueApiCaller.addCatalogueApiCaller(folderName: request.folder_name) { [weak self] result in
            switch result {
            case .success(let data):
                self?.responseModel = data
                completion(.goAhead)
//                DispatchQueue.main.async {
//                    AlertView.showAlert("Alert!", message: data.message ?? "ContactsCon", okTitle: "OK")
//                }
                print("New catalogue Created ✅✅✅✅")
                
            case .failure(let error):
                completion(.heyStop)
                DispatchQueue.main.async {
                    AlertView.showAlert("Warning!", message: "OOPs! Something Went Wrong!", okTitle: "OK")
                }
            }
        }
    }
}



