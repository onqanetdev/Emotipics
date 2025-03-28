//
//  LoginResponseModel.swift
//  Emotipics
//
//  Created by Onqanet on 27/03/25.
//

import Foundation


struct LoginResponseModel : Codable {
    let status : Int?
    let success : Bool?
    let message : String?
    let login_data : [Login_data]?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case success = "success"
        case message = "message"
        case login_data = "login_data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        login_data = try values.decodeIfPresent([Login_data].self, forKey: .login_data)
    }

}

//MARK: Login Data Model
struct Login_data : Codable {
    let user : User?
    let access_token : String?

    enum CodingKeys: String, CodingKey {

        case user = "user"
        case access_token = "access_token"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        user = try values.decodeIfPresent(User.self, forKey: .user)
        access_token = try values.decodeIfPresent(String.self, forKey: .access_token)
    }

}


//MARK: User Data Model
struct User : Codable {
    let id : Int?
    let uuid : String?
    let code : String?
    let name : String?
    let email : String?
    let verify : String?
    let phone : String?
//    let email_verified_at : String?
    let active : String?
    let delete_account : String?
    let created_at : String?
    let updated_at : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case uuid = "uuid"
        case code = "code"
        case name = "name"
        case email = "email"
        case verify = "verify"
        case phone = "phone"
        //case email_verified_at = "email_verified_at"
        case active = "active"
        case delete_account = "delete_account"
        case created_at = "created_at"
        case updated_at = "updated_at"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        uuid = try values.decodeIfPresent(String.self, forKey: .uuid)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        verify = try values.decodeIfPresent(String.self, forKey: .verify)
        phone = try values.decodeIfPresent(String.self, forKey: .phone)
       // email_verified_at = try values.decodeIfPresent(String.self, forKey: .email_verified_at)
        active = try values.decodeIfPresent(String.self, forKey: .active)
        delete_account = try values.decodeIfPresent(String.self, forKey: .delete_account)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
    }

}

