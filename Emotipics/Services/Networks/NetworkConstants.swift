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
//    case register = "/auth/register"
//    case userProfile = "/user/profile"
}

let baseURL = "https://onqanet.net/dev_biltu01/emotipics/api/"


