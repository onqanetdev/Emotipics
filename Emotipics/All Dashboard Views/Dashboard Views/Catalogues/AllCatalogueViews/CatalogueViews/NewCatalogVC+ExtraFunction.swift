//
//  NewCatalogVC+ExtraFunction.swift
//  Emotipics
//
//  Created by Onqanet on 20/05/25.
//

import Foundation
import UIKit



extension NewCatalogueVC: DeleteCatalogDelegate, SharedInformationDelegate {
    
    
    @objc func deleteCatalogueBtnAction(_ sender: UIButton) {
        
        indexNo = sender.tag
        
        //deleteCatalogGlobalPopUp()
        self.deleteCatalogPopUp()
        
        
        
    }
    
    
    func deleteCatalogPopUp() {
        let errorPopup = DeleteCatalogPopVC(nibName: "DeleteCatalogPopVC", bundle: nil)
        
        errorPopup.modalPresentationStyle = .overCurrentContext
        errorPopup.modalTransitionStyle = .crossDissolve
        // errorPopup.delegate = self
        errorPopup.onCompletion = { [weak self] result in
            switch result {
            case .YES:
                print("✅ User confirmed delete!")
                
                // Wait for popup to finish dismissing before presenting the next one
                errorPopup.dismiss(animated: true) {
                    // self?.deleteCatalogPopUp()
                    self?.deleteCatalogGlobalPopUp()
                    print("Print Nothing")
                }
                
            case .NO:
                print("User canceled delete.")
                errorPopup.dismiss(animated: true, completion: nil)
            case .SHARE:
                //print("Sharing Catalog from DeleteCatalogPopVC")
                errorPopup.dismiss(animated: true) {
                    self?.presentShareScreen()
                }
            case .RENAME:
                errorPopup.dismiss(animated: true) {
                    self?.presentRenameCatalogueScreen()
                    
                }
            case .DETAILS:
                print("Details has not been filled yet from New Catalogue View")
                
                errorPopup.dismiss(animated: true){
                    self?.presentDetailsScreen()
                }
            }
        }
        
        self.present(errorPopup, animated: true)
    }
    
    
    func deleteCatalogGlobalPopUp() {
        let errorPopup = DeleteCatalogueGlobalPopUp(nibName: "DeleteCatalogueGlobalPopUp", bundle: nil)
        errorPopup.modalPresentationStyle = .overCurrentContext
        errorPopup.modalTransitionStyle = .crossDissolve
        errorPopup.delegate = self
        self.present(errorPopup, animated: true)
    }
    
    func presentShareScreen() {
        
        let shareInfo = SharedInformationVC(nibName: "SharedInformationVC", bundle: nil)
        shareInfo.modalPresentationStyle = .overCurrentContext
        shareInfo.modalTransitionStyle = .crossDissolve
        shareInfo.delegate = self
        
        if let sharedList = catalogueListingViewModel.responseModel?.data?[indexNo].sharedcatalog,
           let catalogName = catalogueListingViewModel.responseModel?.data?[indexNo].catalog_name{
            
            shareInfo.temporaryMemory = sharedList
            shareInfo.catalogueNameText = catalogName
            
        } else {
            AlertView.showAlert("Warning!", message: "There is no memory", okTitle: "OK")
        }
        
        
        
        self.present(shareInfo, animated: true, completion: nil)
    }
    
    
    func didTapProceed() {
        let shareVC = SharingContactListVC(nibName: "SharingContactListVC", bundle: nil)
        shareVC.modalPresentationStyle = .fullScreen
        guard let catalogDataGet = catalogueListingViewModel.responseModel?.data else {
            AlertView.showAlert("Warning!", message: "There is No data in catalogue", okTitle: "OK")
            return
        }
        shareVC.catalogData = catalogDataGet
        shareVC.shareIndex = indexNo
        
        
        
        self.present(shareVC, animated: true, completion: nil)
    }
    
    
    func deletePopup(){
        //print("Testing Testing 👹👹👹👹👹👹👹👹👹👹👹👹👹👹👹👹👹👹👹👹👹")
        deleteCatalogueFunction(pin: indexNo)
    }
    
    func deleteCatalogueFunction(pin: Int){
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
                    self.catalogueCollView.reloadData()
                    
//                    if self.tempMemory.isEmpty {
//                        self.emptyViewForCatalogueView.isHidden = false
//                        self.catalougeCollView.isHidden = true
//                    } else {
//                        self.emptyViewForCatalogueView.isHidden = true
//                        self.catalougeCollView.isHidden = false
//                    }
                case .heyStop:
                    print("Error")
                }
                
                
            }
            
            
        }
    }
    
    
    
    func presentRenameCatalogueScreen() {
        print("folder name is ", tempMemory[indexNo].catalog_name)
        print("folder uuid is ", tempMemory[indexNo].catalogue_uuid)
        let renameCatalogue = RenameCatalogueVC(nibName: "RenameCatalogueVC", bundle: nil)
        renameCatalogue.modalPresentationStyle = .overCurrentContext
        renameCatalogue.modalTransitionStyle = .crossDissolve
        
        renameCatalogue.onDismiss = { [weak self] in
            //self?.tblViewForGroups.reloadData()
            //self?.loadingAllGroups()
            self?.loadAllCatalogueData()
            }
        
        guard let catalogUUID = tempMemory[indexNo].catalogue_uuid else {
            return
        }
        renameCatalogue.folder_UUID = catalogUUID
        self.present(renameCatalogue, animated: true, completion: nil)
    }
    
    
    func presentDetailsScreen(){
       
        let detailScreen = DetailsOfDetailsPopUpVC(nibName: "DetailsOfDetailsPopUpVC", bundle: nil)
        detailScreen.modalPresentationStyle = .overCurrentContext
        detailScreen.modalTransitionStyle = .crossDissolve
        
        
        guard let  ownerName = tempMemory[indexNo].owner_detials?.name,
              let groupName = tempMemory[indexNo].catalog_name,
              let totalUserCount = tempMemory[indexNo].members,
              let createdDate = tempMemory[indexNo].datetime else {
                  return
              }
        
        detailScreen.ownerNameVar = ownerName
        detailScreen.grpNmVar = groupName
        detailScreen.totalUserVar = totalUserCount
        detailScreen.createdDateVar = createdDate
        detailScreen.catalogName = "Catalogue Name"
        
        self.present(detailScreen, animated: true)
    }
}
