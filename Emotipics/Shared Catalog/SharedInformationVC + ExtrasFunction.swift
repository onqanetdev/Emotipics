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
    
    
}
