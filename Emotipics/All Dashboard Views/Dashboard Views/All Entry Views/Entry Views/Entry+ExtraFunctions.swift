//
//  Entry+ExtraFunctions.swift
//  Emotipics
//
//  Created by Onqanet on 10/04/25.
//

import Foundation



extension EntryViewController: DeleteCatalogDelegate {
    func deleteCatalogueFunction(pin: Int){
        
        if tempMemory.isEmpty {
            
        }
        
        
        guard let item = tempMemory[pin].catalogue_uuid else {
            return
        }
        
        
        
        //self.activityIndicator.startAnimating()
        startCustomLoader()
        deleteCatalogueViewModel.requestModel.UUID = item
        deleteCatalogueViewModel.deleteCatalogViewModel(request: deleteCatalogueViewModel.requestModel) { result in
            DispatchQueue.main.async {
                //self.activityIndicator.stopAnimating()
                self.stopCustomLoader()
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
    
    
    func presentRenameCatalogueScreen() {
        print("folder name is ", tempMemory[indexNo].catalog_name)
        print("folder uuid is ", tempMemory[indexNo].catalogue_uuid)
        let renameCatalogue = RenameCatalogueVC(nibName: "RenameCatalogueVC", bundle: nil)
        renameCatalogue.modalPresentationStyle = .overCurrentContext
        renameCatalogue.modalTransitionStyle = .crossDissolve
        guard let catalogUUID = tempMemory[indexNo].catalogue_uuid else {
            return
        }
        renameCatalogue.folder_UUID = catalogUUID
        self.present(renameCatalogue, animated: true, completion: nil)
    }
}

