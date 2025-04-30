//
//  GroupListViewController+ExtraFunctions.swift
//  Emotipics
//
//  Created by Onqanet on 29/04/25.
//

import Foundation


extension GroupListViewController: SharedInformationDelegate {
    
    
    func presentRenameGroupScreen() {
        print("Group name is ", newResultArray[indexNo].groupname)
        print("Group Code is ", newResultArray[indexNo].group_code)
        let renameCatalogue = RenameCatalogueVC(nibName: "RenameCatalogueVC", bundle: nil)
        renameCatalogue.modalPresentationStyle = .overCurrentContext
        renameCatalogue.modalTransitionStyle = .crossDissolve
        guard let grpCodee = newResultArray[indexNo].group_code else {
            return
        }
       // renameCatalogue.folder_UUID = catalogUUID
        renameCatalogue.renameGrp = true
        renameCatalogue.groupCode = grpCodee
        
        
        renameCatalogue.onDismiss = { [weak self] in
            //self?.tblViewForGroups.reloadData()
            self?.loadingAllGroups()
            }
        
        self.present(renameCatalogue, animated: true, completion: nil)
    }
    
    
    
    func presentShareScreen() {
        
        let shareInfo = SharedInformationVC(nibName: "SharedInformationVC", bundle: nil)
        shareInfo.modalPresentationStyle = .overCurrentContext
        shareInfo.modalTransitionStyle = .crossDissolve
        shareInfo.groupSharingVC = true
        
        shareInfo.delegate = self
        
            
            //shareInfo.temporaryMemory =
        if let groupName = newResultArray[indexNo].groupname, let explicitArray = newResultArray[indexNo].sharebyme, let gropCode = newResultArray[indexNo].group_code {
            shareInfo.catalogueNameText = groupName
            shareInfo.grpTempMemory = explicitArray
            shareInfo.groupCode = gropCode
        } else {
            AlertView.showAlert("Warning!", message: "There is no group name", okTitle: "OK")
        }
        self.present(shareInfo, animated: true, completion: nil)
    }
    
    
    
    func didTapProceed() {
        let shareVC = SharingContactListVC(nibName: "SharingContactListVC", bundle: nil)
        shareVC.modalPresentationStyle = .fullScreen
        
        
        guard let groupDataGet = groupListingView.responseModel?.data else {
            AlertView.showAlert("Warning!", message: "There is No data in catalogue", okTitle: "OK")
            return
        }
        shareVC.groupData = groupDataGet
        shareVC.groupCode = groupDataGet[indexNo].group_code ?? "0"
        print("Group Code is",groupDataGet[indexNo].group_code )
        shareVC.shareIndex = indexNo
        shareVC.contactListForGr = true
        self.present(shareVC, animated: true, completion: nil)
    }
}
