//
//  Entry+ExtraFunctions.swift
//  Emotipics
//
//  Created by Onqanet on 10/04/25.
//

import Foundation



extension EntryViewController: DeleteCatalogDelegate {
    func deleteCatalogueFunction(pin: Int){
        guard let item = tempMemory[pin].catalogue_uuid else {
            return
        }
        
        
        
        self.activityIndicator.startAnimating()
        deleteCatalogueViewModel.requestModel.UUID = item
        deleteCatalogueViewModel.deleteCatalogViewModel(request: deleteCatalogueViewModel.requestModel) { result in
            DispatchQueue.main.async {
                self.activityIndicator.stopAnimating()
                
                switch result {
                case .goAhead:
                    print("Catalogue View Model from Catalogue View Controller")
                    self.tempMemory.remove(at: pin)
                    self.fileColView.reloadData()
                    //self.deleteProductLocally(at: sender.tag)
                    //table View Reload Data
                    //self.fileColView.reloadData()
                case .heyStop:
                    print("Error")
                }
                
                
            }
            
            
        }
    }
    
    
    func deletePopup(){
       // print("Testing Testing 👹👹👹👹👹👹👹👹👹👹👹👹👹👹👹👹👹👹👹👹👹")
        deleteCatalogueFunction(pin: indexNo)
    }
    
}

