//
//  CatalogueRenameResModel.swift
//  Emotipics
//
//  Created by Onqanet on 25/04/25.
//

import Foundation




struct CatalogueRenameResModel: Codable {
    let status : Int?
    let success : Bool?
    let message : String?
    let data : DataNew?

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
        data = try values.decodeIfPresent(DataNew.self, forKey: .data)
    }

}




struct DataNew: Codable {
    let catalogue_uuid : String?
    let catalog_code : String?
    let catalog_base_name : String?
    let catalog_name : String?
    let total_files : String?
    let file_storage : String?
    let create : String?
    let modify : String?

    enum CodingKeys: String, CodingKey {

        case catalogue_uuid = "catalogue_uuid"
        case catalog_code = "catalog_code"
        case catalog_base_name = "catalog_base_name"
        case catalog_name = "catalog_name"
        case total_files = "total_files"
        case file_storage = "file_storage"
        case create = "create"
        case modify = "modify"
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
    }

}

