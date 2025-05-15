//
//  GroupImageListResModel.swift
//  Emotipics
//
//  Created by Onqanet on 05/05/25.
//

import Foundation



struct GroupImageListResModel:Codable {
    let status : Int?
    let success : Bool?
    let message : String?
    let data : [GroupImageData]?
    let currentpage : Int?
    let totalpage : Int?
    
    let groupname : String?
    let member_count : Int?
    let created_date : String?
    let owner : String?
    let owner_email : String?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case success = "success"
        case message = "message"
        case data = "data"
        case currentpage = "currentpage"
        case totalpage = "totalpage"
        
        
        case groupname = "groupname"
        case member_count = "member_count"
        case created_date = "created_date"
        case owner = "owner"
        case owner_email = "owner_email"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent([GroupImageData].self, forKey: .data)
        currentpage = try values.decodeIfPresent(Int.self, forKey: .currentpage)
        totalpage = try values.decodeIfPresent(Int.self, forKey: .totalpage)
        
        
        groupname = try values.decodeIfPresent(String.self, forKey: .groupname)
        member_count = try values.decodeIfPresent(Int.self, forKey: .member_count)
        created_date = try values.decodeIfPresent(String.self, forKey: .created_date)
        owner = try values.decodeIfPresent(String.self, forKey: .owner)
        owner_email = try values.decodeIfPresent(String.self, forKey: .owner_email)
    }

}





struct GroupImageData:Codable {
    let id : Int?
    let img_type : String?
    let group_code : String?
    let catalog_code : String?
    let user_code : String?
    let img_name : String?
    let img_size : String?
    let status : String?
    let created_at : String?
    let updated_at : String?
    let datetime : String?
    let members : Int?
    let image_size : String?
    let imagesize : String?
    //let emoji : [String]?
    let emoji : [Emoji]?
    let emojicount : Int?
    let path : String?
    let user : folderOwner?

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
        case emoji = "emoji"
        case emojicount = "emojicount"
        case path = "path"
        case user = "user"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        img_type = try values.decodeIfPresent(String.self, forKey: .img_type)
        group_code = try values.decodeIfPresent(String.self, forKey: .group_code)
        catalog_code = try values.decodeIfPresent(String.self, forKey: .catalog_code)
        user_code = try values.decodeIfPresent(String.self, forKey: .user_code)
        img_name = try values.decodeIfPresent(String.self, forKey: .img_name)
        img_size = try values.decodeIfPresent(String.self, forKey: .img_size)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
        datetime = try values.decodeIfPresent(String.self, forKey: .datetime)
        members = try values.decodeIfPresent(Int.self, forKey: .members)
        image_size = try values.decodeIfPresent(String.self, forKey: .image_size)
        imagesize = try values.decodeIfPresent(String.self, forKey: .imagesize)
//        emoji = try values.decodeIfPresent([String].self, forKey: .emoji)
        emoji = try values.decodeIfPresent([Emoji].self, forKey: .emoji)
        emojicount = try values.decodeIfPresent(Int.self, forKey: .emojicount)
        path = try values.decodeIfPresent(String.self, forKey: .path)
        user = try values.decodeIfPresent(folderOwner.self, forKey: .user)
    }

}








