//
//  CatalogueListingDataModel.swift
//  Emotipics
//
//  Created by Onqanet on 07/04/25.
//

import Foundation




struct CatalogueListingDataModel: Codable {
    let status : Int?
    let success : Bool?
    let message : String?
    let data : [DataM]?
    let currentpage : Int?
    let totalpage : Int?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case success = "success"
        case message = "message"
        case data = "data"
        case currentpage = "currentpage"
        case totalpage = "totalpage"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent([DataM].self, forKey: .data)
        currentpage = try values.decodeIfPresent(Int.self, forKey: .currentpage)
        totalpage = try values.decodeIfPresent(Int.self, forKey: .totalpage)
    }

}


struct DataM: Codable {
    let catalogue_uuid : String?
    let catalog_code : String?
    let catalog_base_name : String?
    let catalog_name : String?
    let total_files : String?
    let file_storage : String?
    let create : String?
    let modify : String?
    let datetime : String?
    let members : Int?
    //
    let catalogimagesize : String?
    let totalcatalogfile : Int?
    
    let owner_detials : Owner_detials?
    let sharedcatalog : [Sharedcatalog]?

    enum CodingKeys: String, CodingKey {

        case catalogue_uuid = "catalogue_uuid"
        case catalog_code = "catalog_code"
        case catalog_base_name = "catalog_base_name"
        case catalog_name = "catalog_name"
        case total_files = "total_files"
        case file_storage = "file_storage"
        case create = "create"
        case modify = "modify"
        case datetime = "datetime"
        case members = "members"
        //
        case catalogimagesize = "catalogimagesize"
        case totalcatalogfile = "totalcatalogfile"
        case owner_detials = "owner_detials"
        case sharedcatalog = "sharedcatalog"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        catalogue_uuid = try values.decodeIfPresent(String.self, forKey: .catalogue_uuid)
        catalog_code = try values.decodeIfPresent(String.self, forKey: .catalog_code)
        catalog_base_name = try values.decodeIfPresent(String.self, forKey: .catalog_base_name)
        catalog_name = try values.decodeIfPresent(String.self, forKey: .catalog_name)
        total_files = try values.decodeIfPresent(String.self, forKey: .total_files)
        file_storage = try values.decodeIfPresent(String.self, forKey: .file_storage)
        create = try values.decodeIfPresent(String.self, forKey: .create)
        modify = try values.decodeIfPresent(String.self, forKey: .modify)
        datetime = try values.decodeIfPresent(String.self, forKey: .datetime)
        members = try values.decodeIfPresent(Int.self, forKey: .members)
        //
        catalogimagesize = try values.decodeIfPresent(String.self, forKey: .catalogimagesize)
        totalcatalogfile = try values.decodeIfPresent(Int.self, forKey: .totalcatalogfile)
        
        owner_detials = try values.decodeIfPresent(Owner_detials.self, forKey: .owner_detials)
        sharedcatalog = try values.decodeIfPresent([Sharedcatalog].self, forKey: .sharedcatalog)
    }

}


struct Sharedcatalog : Codable {
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



struct Owner_detials : Codable {
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



//trying contactlist

struct Contactlist: Codable {
    let id: Int
    let contactcode, ownerID, contactID: String
    let contactdetails: Contactdetails?

    enum CodingKeys: String, CodingKey {
        case id, contactcode
        case ownerID = "owner_id"
        case contactID = "contact_id"
        case contactdetails
    }
}
