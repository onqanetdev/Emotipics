//
//  GroupRenameResModel.swift
//  Emotipics
//
//  Created by Onqanet on 29/04/25.
//

import Foundation


struct GroupRenameResModel: Codable {
    let status : Int?
    let success : Bool?
    let data : RenameData?
    let message : String?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case success = "success"
        case data = "data"
        case message = "message"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        data = try values.decodeIfPresent(RenameData.self, forKey: .data)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }

}



struct RenameData: Codable {
    let id : Int?
    let user_code : String?
    let group_code : String?
    let groupname : String?
    let status : String?
    let is_delete : String?
    let created_at : String?
    let updated_at : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case user_code = "user_code"
        case group_code = "group_code"
        case groupname = "groupname"
        case status = "status"
        case is_delete = "is_delete"
        case created_at = "created_at"
        case updated_at = "updated_at"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        user_code = try values.decodeIfPresent(String.self, forKey: .user_code)
        group_code = try values.decodeIfPresent(String.self, forKey: .group_code)
        groupname = try values.decodeIfPresent(String.self, forKey: .groupname)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        is_delete = try values.decodeIfPresent(String.self, forKey: .is_delete)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
    }

}






