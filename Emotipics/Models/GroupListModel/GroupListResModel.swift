//
//  GroupListResModel.swift
//  Emotipics
//
//  Created by Onqanet on 28/04/25.
//

import Foundation



struct GroupListResModel: Codable {
    let status : Int?
    let success : Bool?
    let data : [GroupData]?
    let currentpage : Int?
    let totalpage : Int?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case success = "success"
        case data = "data"
        case currentpage = "currentpage"
        case totalpage = "totalpage"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        data = try values.decodeIfPresent([GroupData].self, forKey: .data)
        currentpage = try values.decodeIfPresent(Int.self, forKey: .currentpage)
        totalpage = try values.decodeIfPresent(Int.self, forKey: .totalpage)
    }

}


struct GroupData: Codable {
    let id : Int?
    let user_code : String?
    let group_code : String?
    let groupname : String?
    let status : String?
    let is_delete : String?
    let created_at : String?
    let updated_at : String?
    let datetime : String?
    let members : Int?
    let owner_detials : folderOwner?
    //let sharebyme : [String]?
    let sharebyme : [ShareByMe]?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case user_code = "user_code"
        case group_code = "group_code"
        case groupname = "groupname"
        case status = "status"
        case is_delete = "is_delete"
        case created_at = "created_at"
        case updated_at = "updated_at"
        case datetime = "datetime"
        case members = "members"
        case owner_detials = "owner_detials"
        case sharebyme = "sharebyme"
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
        datetime = try values.decodeIfPresent(String.self, forKey: .datetime)
        members = try values.decodeIfPresent(Int.self, forKey: .members)
        owner_detials = try values.decodeIfPresent(folderOwner.self, forKey: .owner_detials)
//        sharebyme = try values.decodeIfPresent([String].self, forKey: .sharebyme)
        sharebyme = try values.decodeIfPresent([ShareByMe].self, forKey: .sharebyme)
    }

}


struct folderOwner: Codable {
    let code : String?
    let name : String?
    let email : String?

    enum CodingKeys: String, CodingKey {

        case code = "code"
        case name = "name"
        case email = "email"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        email = try values.decodeIfPresent(String.self, forKey: .email)
    }

}


struct ShareByMe:Codable {
    let id: Int?
    let groupcode: String?
    let contactcode: String?
    let status: String?
    let groupcontact: Datam?
    
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case groupcode = "groupcode"
        case contactcode = "contactcode"
        case status = "status"
        case groupcontact = "groupcontact"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        groupcode = try values.decodeIfPresent(String.self, forKey: .groupcode)
        contactcode = try values.decodeIfPresent(String.self, forKey: .contactcode)
        
        status = try values.decodeIfPresent(String.self, forKey: .status)
        groupcontact = try values.decodeIfPresent(Datam.self, forKey: .groupcontact)
    }
    
    
}



