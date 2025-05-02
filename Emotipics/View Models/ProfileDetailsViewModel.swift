//
//  ProfileDetailsViewModel.swift
//  Emotipics
//
//  Created by Onqanet on 02/05/25.
//

import Foundation





class ProfileDetailsViewModel {
    var responseModel: ProfileDetailsResModel?
    
    func profileDetailsViewModel(completion: @escaping(_ result: userDataDefination) -> Void ) {
        ProfileAPICaller.profileAPICaller { [weak self] result in
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



