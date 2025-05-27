//
//  GetContactResponseModel.swift
//  Emotipics
//
//  Created by Onqanet on 04/04/25.
//

import Foundation


struct GetContactResponseModel: Codable {
    let status : Int?
    let success : Bool?
    let data : [Datam]?
    let currentpage : Int?
    let totalpagination : Int?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case success = "success"
        case data = "data"
        case currentpage = "currentpage"
        case totalpagination = "totalpagination"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        data = try values.decodeIfPresent([Datam].self, forKey: .data)
        currentpage = try values.decodeIfPresent(Int.self, forKey: .currentpage)
        totalpagination = try values.decodeIfPresent(Int.self, forKey: .totalpagination)
    }

}


struct Datam : Codable {
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


struct Contactdetails : Codable {
    let code : String?
    let name : String?
    let email : String?
    let dob: String?

    enum CodingKeys: String, CodingKey {

        case code = "code"
        case name = "name"
        case email = "email"
        case dob = "dob"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        dob = try values.decodeIfPresent(String.self, forKey: .dob)
    }

}



