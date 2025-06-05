//
//  Entry+ExtraFunctions.swift
//  Emotipics
//
//  Created by Onqanet on 10/04/25.
//

import Foundation
import UIKit



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



extension EntryViewController {
    
    
    
    func sharedCatalogueList() {
        sharedCatalogueViewModel.requestModel.limit = "10"
        sharedCatalogueViewModel.requestModel.offset = "1"
        sharedCatalogueViewModel.requestModel.sort_folder = "DESC"
        sharedCatalogueViewModel.requestModel.type_of_list = "catalog_share_withme"
        
        // activityIndicator.startAnimating()
        //startCustomLoader(selfView: sharedCatalogueCollView)
        startCustomLoader()
        
        sharedCatalogueViewModel.catalogueListing(request: sharedCatalogueViewModel.requestModel) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }

                
                self.stopCustomLoader()

                switch result {
                case .goAhead:
                    guard let tempMemoryForSharedCat = self.sharedCatalogueViewModel.responseModel?.data else {
                        return
                    }
                    
                    self.sharedCataTempMemory = tempMemoryForSharedCat
                    
                    self.sharedCatalogueCollView.reloadData()
                    
                case .heyStop:
                    print("Error")
                }
            }
        }
    }

    
    
    //MARK: FOR IMAGE SHARED WITH ME SECTION
    

 
    
    func sharedWithMeList() {
        guard let storedCode = UserDefaults.standard.string(forKey: "userCode") else {
            return
        }
        
        sharedImageByMeViewModel.requestModel.limit = "4"
        sharedImageByMeViewModel.requestModel.offset = "1"
        sharedImageByMeViewModel.requestModel.usercode = storedCode
        sharedImageByMeViewModel.requestModel.sharetype = "withme"
        
        startCustomLoader()
        
        sharedImageByMeViewModel.sharedImageByMeViewModel(request: sharedImageByMeViewModel.requestModel) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                
                self.stopCustomLoader()
                
                switch result {
                case .goAhead:
                    guard let value = self.sharedImageByMeViewModel.responseModel?.data else {
                        return
                    }
                    
                    self.sharedImageData = value
                    
                    self.shareWithMeViewHeight.constant = (self.sharedImageData.count <= 2) ? 200 : 400
                    self.sharedImageCollView.reloadData()
                    
                case .heyStop:
                    print("Error")
                }
            }
        }
    }

    
    
    
    func startCustomLoader(selfView: UIView){
        //        let loaderSize: CGFloat = 220
        
        if loaderView != nil { return }
        let loader = ImageLoaderView(frame: view.bounds)
        loader.center = view.center
        loader.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        loader.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        //loader.layer.cornerRadius = 16
        
        selfView.addSubview(loader)
        loader.startAnimating()
        
        self.loaderView = loader
        
        // Stop and remove after 5 seconds
    }
    
    func stopCustomLoader(selfView: UIView){
        print("Trying to stop loader:", loaderView != nil)
        loaderView?.stopAnimating()
        loaderView?.removeFromSuperview()
        
        loaderView = nil
        
        
    }
}
