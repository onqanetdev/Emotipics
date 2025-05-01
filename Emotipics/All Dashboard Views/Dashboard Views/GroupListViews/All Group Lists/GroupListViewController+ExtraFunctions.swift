//
//  GroupListViewController+ExtraFunctions.swift
//  Emotipics
//
//  Created by Onqanet on 29/04/25.
//

import Foundation


extension GroupListViewController: SharedInformationDelegate {
    
    
    
    func detailsPopUp(index:Int) {
        print("Desired Group is ", newResultArray[index].group_code)
        indexNo = index
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
                    
                }
                
            case .NO:
                print("User canceled delete.")
                errorPopup.dismiss(animated: true, completion: nil)
            case .SHARE:
                print("Group Share Tapped ✅")
                
                errorPopup.dismiss(animated: true) {
                    self?.presentShareScreen()
                }
            case .RENAME:
                print("RENAME")
                errorPopup.dismiss(animated: true){
                    self?.presentRenameGroupScreen()
                }
            }
            
            
        }
        
        self.present(errorPopup, animated: true)
    }
    
    
    
//    func exitFromGroupPopUp(index: Int){
//        let errorPopup = ExitFromCataloguePopUp(nibName: "ExitFromCataloguePopUp", bundle: nil)
//        errorPopup.modalPresentationStyle = .overCurrentContext
//        errorPopup.modalTransitionStyle = .crossDissolve
//        errorPopup.isGroupViewCalling = true
//        // errorPopup.delegate = self
//        
//        guard let groupCode = groupListingView.responseModel?.data?[index].group_code else {
//            return
//        }
//        
//        errorPopup.onExitFromGroup = { [weak self] in
//            print("Group Code is--> ", groupCode )
//            self?.groupUserExitViewModel.requestModel.groupCode = groupCode
//            //print("Exit from catalogue tapped. Sender tag is \(sender.tag)")
//            // Handle exit logic here
//            self?.startCustomLoader()
//            self?.groupUserExitViewModel.groupUserExitViewModel(request: (self?.groupUserExitViewModel.requestModel)!) { result in
//                DispatchQueue.main.async {
//                   // self.activityIndicator.stopAnimating()
//                    self?.stopCustomLoader()
//                    switch result {
//                    case .goAhead:
//                        DispatchQueue.main.async {
//                            //self.shareWithMe()
//                       // self.sharedCollView.reloadData()
//                            
//                       }
//                    case .heyStop:
//                        print("Error")
//                    }
//                    
//                    
//                }
//                
//                
//            }
//        }
//        
//        self.present(errorPopup, animated: true)
//    }
    
    
    func exitFromGroupPopUp(index: Int) {
        let errorPopup = ExitFromCataloguePopUp(nibName: "ExitFromCataloguePopUp", bundle: nil)
        errorPopup.modalPresentationStyle = .overCurrentContext
        errorPopup.modalTransitionStyle = .crossDissolve
        errorPopup.isGroupViewCalling = true
        // errorPopup.delegate = self
        
        guard let groupCode = groupListingView.responseModel?.data?[index].group_code else {
            return
        }

        errorPopup.onExitFromGroup = { [weak self] in
            guard let self = self else { return }
            print("Group Code is--> ", groupCode)

            self.groupUserExitViewModel.requestModel.groupCode = groupCode

            self.startCustomLoader()

            self.groupUserExitViewModel.groupUserExitViewModel(request: self.groupUserExitViewModel.requestModel) { result in
                DispatchQueue.main.async {
                    self.stopCustomLoader()
                    
                    switch result {
                    case .goAhead:
                        // Handle successful exit
                        //break
                        
                        DispatchQueue.main.async {
                            self.newResultArray.remove(at: index)
                            
                            self.tblViewForGroups.reloadData()
                        }
                        
                    case .heyStop:
                        print("Error")
                    }
                }
            }
        }

        self.present(errorPopup, animated: true)
    }

    
    
    
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
