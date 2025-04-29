//
//  GroupListViewController+ExtraFunctions.swift
//  Emotipics
//
//  Created by Onqanet on 29/04/25.
//

import Foundation


extension GroupListViewController {
    
    
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
}
