//
//  CatalogueImageListResModel.swift
//  Emotipics
//
//  Created by Onqanet on 16/04/25.
//

import Foundation






struct CatalogueImageListResModel: Codable {
    let status : Int?
    let success : Bool?
    let message : String?
    let data : [ImageData]?
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
        data = try values.decodeIfPresent([ImageData].self, forKey: .data)
        currentpage = try values.decodeIfPresent(Int.self, forKey: .currentpage)
        totalpage = try values.decodeIfPresent(Int.self, forKey: .totalpage)
    }

}


struct ImageData: Codable {
    let id : Int?
    let img_type : String?
    let group_code : Int?
    let catalog_code : Int?
    let user_code : Int?
    let img_name : String?
    let img_size : String?
    let status : String?
    let created_at : String?
    let updated_at : String?
    let datetime : String?
    let members : Int?
    let image_size : Int?
    let imagesize : String?
    let path : String?
    let user : ImageUser?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case img_type = "img_type"
        case group_code = "group_code"
        case catalog_code = "catalog_code"
        case user_code = "user_code"
        case img_name = "img_name"
        case img_size = "img_size"
        case status = "status"
        case created_at = "created_at"
        case updated_at = "updated_at"
        case datetime = "datetime"
        case members = "members"
        case image_size = "image_size"
        case imagesize = "imagesize"
        case path = "path"
        case user = "user"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        img_type = try values.decodeIfPresent(String.self, forKey: .img_type)
        group_code = try values.decodeIfPresent(Int.self, forKey: .group_code)
        catalog_code = try values.decodeIfPresent(Int.self, forKey: .catalog_code)
        user_code = try values.decodeIfPresent(Int.self, forKey: .user_code)
        img_name = try values.decodeIfPresent(String.self, forKey: .img_name)
        img_size = try values.decodeIfPresent(String.self, forKey: .img_size)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
        datetime = try values.decodeIfPresent(String.self, forKey: .datetime)
        members = try values.decodeIfPresent(Int.self, forKey: .members)
        image_size = try values.decodeIfPresent(Int.self, forKey: .image_size)
        imagesize = try values.decodeIfPresent(String.self, forKey: .imagesize)
        path = try values.decodeIfPresent(String.self, forKey: .path)
        user = try values.decodeIfPresent(ImageUser.self, forKey: .user)
    }

}



struct ImageUser : Codable {
    let name : String?
    let code : String?
    let email : String?

    enum CodingKeys: String, CodingKey {

        case name = "name"
        case code = "code"
        case email = "email"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        email = try values.decodeIfPresent(String.self, forKey: .email)
    }

}
