//
//  SharedInformationVC + ExtrasFunction.swift
//  Emotipics
//
//  Created by Onqanet on 30/04/25.
//

import Foundation


extension SharedInformationVC {
    func loadingViewsAcc(){
        if groupSharingVC {
            userListForGrp()
            
            
            if grpTempMemory.count == 0 && groupUserList.count == 0{
                emptyView.isHidden = false
                sharedConListTblView.isHidden = true
            } else {
                emptyView.isHidden = true
                sharedConListTblView.isHidden = false
                
            }
            
            
        }
        else
        {
            userListForCatalogue()
            if temporaryMemory.count == 0 {
                emptyView.isHidden = false
                sharedConListTblView.isHidden = true
            } else {
                emptyView.isHidden = true
                sharedConListTblView.isHidden = false
            }
        }
        catalogueName.text = catalogueNameText
        
        
    }
    
    func groupUserDelete(contactId:Int, removeAt: Int){
        groupUserDeleteViewModel.requestModel.contactId = contactId
        startCustomLoader()
        groupUserDeleteViewModel.groupUserDeleteViewModel(request: groupUserDeleteViewModel.requestModel) { result in
            DispatchQueue.main.async {
                //self.activityIndicator.stopAnimating()
                self.stopCustomLoader()
                switch result {
                case .goAhead:
                    print("Shared Catalogue View Model From Shared Catalogue View Controller")
                    //table View Reload Data
                    DispatchQueue.main.async { [self] in
                        //temporaryMemory.remove(at: removeAt)
                        groupUserList.remove(at: removeAt)
                        self.sharedConListTblView.reloadData()
                        
                    }
                case .heyStop:
                    print("Error")
                }
                
                
            }
            
            
        }
    }
    
    func userListForCatalogue(){
        catalogueUserListViewModel.requestModel.catalogueCode = catalogCode
        startCustomLoader()
        catalogueUserListViewModel.catalogueUserListViewModel(request: catalogueUserListViewModel.requestModel)
        { result in
            DispatchQueue.main.async {
                //self.activityIndicator.stopAnimating()
                self.stopCustomLoader()
                switch result {
                case .goAhead:
                    print("Catalog User List Loaded✅")
                    //table View Reload Data
                    DispatchQueue.main.async { [self] in
                        
                        
                        guard let sharedCat = catalogueUserListViewModel.responseModel?.data else {
                            return 
                        }
                        
                        temporaryMemory = sharedCat
                        print("Shared Catalogue ", sharedCat)
                        self.sharedConListTblView.reloadData()
                        
                    }
                case .heyStop:
                    print("Error")
                }
                
                
            }
            
            
        }
    }
}






