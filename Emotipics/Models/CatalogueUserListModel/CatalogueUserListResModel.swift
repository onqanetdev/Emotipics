//
//  CatalogueUserListResModel.swift
//  Emotipics
//
//  Created by Onqanet on 30/04/25.
//

import Foundation




struct CatalogueUserListResModel: Codable {
    let status : Int?
    let success : Bool?
    let message : String?
    let data : [Sharedcatalog]?
    
    enum CodingKeys: String, CodingKey {
        
        case status = "status"
        case success = "success"
        case message = "message"
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent([Sharedcatalog].self, forKey: .data)
    }
    
}


struct CatalogueUserListData:Codable {
    let id : Int?
    let catalogcode : String?
    let contactcode : String?
    let status : String?
    let created_at : String?
    let updated_at : String?
    let contactlist : Contactlist?
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case catalogcode = "catalogcode"
        case contactcode = "contactcode"
        case status = "status"
        case created_at = "created_at"
        case updated_at = "updated_at"
        case contactlist = "contactlist"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        catalogcode = try values.decodeIfPresent(String.self, forKey: .catalogcode)
        contactcode = try values.decodeIfPresent(String.self, forKey: .contactcode)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
        contactlist = try values.decodeIfPresent(Contactlist.self, forKey: .contactlist)
    }
    
}
