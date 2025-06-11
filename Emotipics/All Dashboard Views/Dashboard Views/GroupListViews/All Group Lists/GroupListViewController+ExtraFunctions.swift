//
//  GroupListViewController+ExtraFunctions.swift
//  Emotipics
//
//  Created by Onqanet on 29/04/25.
//

import Foundation
import UIKit


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
            case .DETAILS:
                print("Detailsss")
                errorPopup.dismiss(animated: true){
                    self?.presentDetailsScreen()
                }
            }
            
            
        }
        
        self.present(errorPopup, animated: true)
    }
    
    
    

    
    
    func exitFromGroupPopUp(index: Int) {
        indexNo = index
        let errorPopup = ExitFromCataloguePopUp(nibName: "ExitFromCataloguePopUp", bundle: nil)
        errorPopup.modalPresentationStyle = .overCurrentContext
        errorPopup.modalTransitionStyle = .crossDissolve
        errorPopup.isGroupViewCalling = true
        // errorPopup.delegate = self
        
//        guard let groupCode = groupListingView.responseModel?.data?[index].group_code else {
//            return
//        }
//        
        
        guard let groupCode = newResultArray[index].group_code else {
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
        
       
        
        
        errorPopup.onShareGroup = { [weak self] in
            guard let self = self else { return }
            
           
            
            errorPopup.dismiss(animated: true) {
                //self.presentShareScreen()
                self.presentShareScreenForGroup()
            }
            
            
        }
        
    
        self.present(errorPopup, animated: true)
    }


    func presentShareScreenForGroup() {
        
        let shareInfo = SharedInformationVC(nibName: "SharedInformationVC", bundle: nil)
        shareInfo.modalPresentationStyle = .overCurrentContext
        shareInfo.modalTransitionStyle = .crossDissolve
        shareInfo.groupSharingVC = true
        shareInfo.isButtonShown = true
        shareInfo.deleteBtnIsHidden = true
        shareInfo.delegate = self
        
            
            //shareInfo.temporaryMemory =
        if let groupName = newResultArray[indexNo].groupname, 
            let explicitArray = newResultArray[indexNo].sharebyme,
            let gropCode = newResultArray[indexNo].group_code,
           let groupOwnerName = newResultArray[indexNo].owner_detials?.name {
            shareInfo.catalogueNameText = groupName
            
            shareInfo.ownerName = groupOwnerName
            shareInfo.grpTempMemory = explicitArray
            shareInfo.groupCode = gropCode
        } else {
            AlertView.showAlert("Warning!", message: "There is no group name", okTitle: "OK")
        }
        self.present(shareInfo, animated: true, completion: nil)
    }
    
    
    
    
    func presentRenameGroupScreen() {
         
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
        shareInfo.deleteBtnIsHidden = false
            
            //shareInfo.temporaryMemory =
         if let groupName = newResultArray[indexNo].groupname, 
            let explicitArray = newResultArray[indexNo].sharebyme,
            let gropCode = newResultArray[indexNo].group_code,
            let groupOwnerName = newResultArray[indexNo].owner_detials?.name
             {
            shareInfo.catalogueNameText = groupName
            
            shareInfo.ownerName = groupOwnerName
            shareInfo.grpTempMemory = explicitArray
            shareInfo.groupCode = gropCode
        } else {
            AlertView.showAlert("Warning!", message: "There is no group name", okTitle: "OK")
        }
        self.present(shareInfo, animated: true, completion: nil)
    }
    
    
    
    func presentDetailsScreen(){
       
        let detailScreen = DetailsOfDetailsPopUpVC(nibName: "DetailsOfDetailsPopUpVC", bundle: nil)
        detailScreen.modalPresentationStyle = .overCurrentContext
        detailScreen.modalTransitionStyle = .crossDissolve
        
        
        guard let  ownerName = newResultArray[indexNo].owner_detials?.name,
              let groupName = newResultArray[indexNo].groupname,
              let totalUserCount = newResultArray[indexNo].members,
              let createdDate = newResultArray[indexNo].datetime else {
                  return
              }
        
        detailScreen.ownerNameVar = ownerName
        detailScreen.grpNmVar = groupName
        detailScreen.totalUserVar = totalUserCount
        detailScreen.createdDateVar = createdDate
        
        
        self.present(detailScreen, animated: true)
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
    
        shareVC.shareIndex = indexNo
        shareVC.contactListForGr = true
        self.present(shareVC, animated: true, completion: nil)
    }
}



extension GroupListViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let position = scrollView.contentOffset.y
        let contentHeight = tblViewForGroups.contentSize.height
        let frameHeight = scrollView.frame.size.height
        
        if position > (contentHeight - frameHeight - 10), !isPaginating{
           
            paginateGroupList()
        }
    }
   
    func paginateGroupList(){
        isPaginating = true
        footerActivityIndicator.startAnimating()
        currentPage += 1
        
        
        groupListingView.requestModel.limit = "10"
        groupListingView.requestModel.offset = "\(currentPage)"
       // startCustomLoader()
        
        groupListingView.groupListViewModelFunc(request: groupListingView.requestModel) { [weak self] result in
            DispatchQueue.main.async {
                guard let self = self else { return }
                //self.stopCustomLoader()
                self.footerActivityIndicator.stopAnimating()
                self.isPaginating = false
                switch result {
                case .goAhead:
                    
                    guard let resultArray = self.groupListingView.responseModel?.data else {
                        return
                    }
                    
                    //self.newResultArray = resultArray
                    self.newResultArray.append(contentsOf: resultArray)
                    self.tblViewForGroups.reloadData()
                    
                case .heyStop:
                    print("Error")
                }
            }
        }
    }
}






