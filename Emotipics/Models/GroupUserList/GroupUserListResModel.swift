//
//  GroupUserListResModel.swift
//  Emotipics
//
//  Created by Onqanet on 30/04/25.
//

import Foundation




struct GroupUserListResModel: Codable {
    let status : Int?
    let success : Bool?
    let data : [GroupUserListData]?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case success = "success"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        data = try values.decodeIfPresent([GroupUserListData].self, forKey: .data)
    }

}

struct GroupUserListData: Codable {
    let id : Int?
    let groupcode : String?
    let contactcode : String?
    let status : String?
    let created_at : String?
    let updated_at : String?
    let groupcontact : Groupcontact?
    
    let owner_detials : Owner_detials?
    let sharebyme : [ShareByMe]?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case groupcode = "groupcode"
        case contactcode = "contactcode"
        case status = "status"
        case created_at = "created_at"
        case updated_at = "updated_at"
        case groupcontact = "groupcontact"
        
        case owner_detials = "owner_detials"
        case sharebyme = "sharebyme"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        groupcode = try values.decodeIfPresent(String.self, forKey: .groupcode)
        contactcode = try values.decodeIfPresent(String.self, forKey: .contactcode)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
        groupcontact = try values.decodeIfPresent(Groupcontact.self, forKey: .groupcontact)
        
        owner_detials = try values.decodeIfPresent(Owner_detials.self, forKey: .owner_detials)
        sharebyme = try values.decodeIfPresent([ShareByMe].self, forKey: .sharebyme)
    }

}



struct Groupcontact: Codable {
    let id : Int?
    let contactcode : String?
    let owner_id : String?
    let contact_id : String?
    let contactdetails : Contactdetails?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case contactcode = "contactcode"
        case owner_id = "owner_id"
        case contact_id = "contact_id"
        case contactdetails = "contactdetails"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        contactcode = try values.decodeIfPresent(String.self, forKey: .contactcode)
        owner_id = try values.decodeIfPresent(String.self, forKey: .owner_id)
        contact_id = try values.decodeIfPresent(String.self, forKey: .contact_id)
        contactdetails = try values.decodeIfPresent(Contactdetails.self, forKey: .contactdetails)
    }

}
