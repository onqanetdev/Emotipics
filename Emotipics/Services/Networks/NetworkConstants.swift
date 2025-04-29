//
//  NetworkConstants.swift
//  Emotipics
//
//  Created by Onqanet on 27/03/25.
//

import Foundation




enum APIEndpoint: String {
    case login = "login"
    case register = "register"
    case otpVerication = "otp-verification"
    case pinSet = "user-login-pin-set"
    case userConAdded = "user-add-contact"
    case userContactList = "user-contact-list"
    case deleteConatct = "user-contact-remove"
    case catalogueListing = "all-catalog-list"
    case addCatalogue = "catalog-create"
    case removeCatalog = "catalog-delete"
    case catalogueUserAdd = "catalog-user-add"
    case catalogImageList = "catalog-images"
    case catalogueImageDelete = "image-delete"
    case imageCopyOrMove = "catalogaction"
    case imageShareWithUser = "share-image"
    case sharedImageList = "share-image-list"
    case dashboard = "dashboard"
    case userDeleteCatalogue = "catalog-user-remove"
    case catalogueRename = "catalog-rename"
    case catalogueUserExit = "catalog-user-exit"
//    case register = "/auth/register"
//    case userProfile = "/user/profile"
    
    case grpCreate = "user-create-group"
    case grpList = "user-list-group"
    case grpDelete = "user-remove-group"
    case grpRename = "user-rename-group"
}

let baseURL = "https://onqanet.net/dev_biltu01/emotipics/api/"


