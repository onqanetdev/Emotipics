//
//  RegisterViewController+Extra Functions.swift
//  Emotipics
//
//  Created by Onqanet on 01/05/25.
//

import Foundation




extension RegisterViewController {
    func forgetPasswordfunction(){
        
     //   setUpNewPinVC()
        
        let renameCatalogue = RenameCatalogueVC(nibName: "RenameCatalogueVC", bundle: nil)
        renameCatalogue.modalPresentationStyle = .overCurrentContext
        renameCatalogue.modalTransitionStyle = .crossDissolve
        //renameCatalogue.renameLbl.text = "Forgot Password"

        renameCatalogue.isForgetPassWord = true
        
        renameCatalogue.onForgetPassword = { [weak self] in
            print("Callback triggered!")
            self?.setUpNewPinVC()
        }
        
        self.present(renameCatalogue, animated: true, completion: nil)
    }
    
    func setUpNewPinVC() {
        let setUpNewPin = SetNewLoginPinVC(nibName: "SetNewLoginPinVC", bundle: nil)
        setUpNewPin.modalPresentationStyle = .overCurrentContext
        setUpNewPin.modalTransitionStyle = .crossDissolve
//        guard let grpCodee = newResultArray[indexNo].group_code else {
//            return
//        }
       // renameCatalogue.folder_UUID = catalogUUID
//        setUpNewPin.renameGrp = true
//        renameCatalogue.groupCode = grpCodee
        
        
//        setUpNewPin.onDismiss = { [weak self] in
//            //self?.tblViewForGroups.reloadData()
//            self?.loadingAllGroups()
//            }
        
        self.present(setUpNewPin, animated: true, completion: nil)
    }
    
  
}

