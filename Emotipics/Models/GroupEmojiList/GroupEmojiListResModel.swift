//
//  GroupEmojiListResModel.swift
//  Emotipics
//
//  Created by Onqanet on 06/05/25.
//

import Foundation





struct GroupEmojiListResModel: Codable {
    let status : Int?
    let success : Bool?
    let message : String?
    let data : [ShowGroupEmojiList]?
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
        data = try values.decodeIfPresent([ShowGroupEmojiList ].self, forKey: .data)
        currentpage = try values.decodeIfPresent(Int.self, forKey: .currentpage)
        totalpage = try values.decodeIfPresent(Int.self, forKey: .totalpage)
    }

}


struct ShowGroupEmojiList: Codable {
    let id : Int?
    let user_code : String?
    let emoji_code : String?
    let group_code : String?
    let image_id : Int?
    let status : String?
    let created_at : String?
    let updated_at : String?
    let datetime : String?
    let emojicount : Int?
    let imagepath : String?
    let user : folderOwner?
    let image : ImageShow?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case user_code = "user_code"
        case emoji_code = "emoji_code"
        case group_code = "group_code"
        case image_id = "image_id"
        case status = "status"
        case created_at = "created_at"
        case updated_at = "updated_at"
        case datetime = "datetime"
        case emojicount = "emojicount"
        case imagepath = "imagepath"
        case user = "user"
        case image = "image"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        user_code = try values.decodeIfPresent(String.self, forKey: .user_code)
        emoji_code = try values.decodeIfPresent(String.self, forKey: .emoji_code)
        group_code = try values.decodeIfPresent(String.self, forKey: .group_code)
        image_id = try values.decodeIfPresent(Int.self, forKey: .image_id)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
        datetime = try values.decodeIfPresent(String.self, forKey: .datetime)
        emojicount = try values.decodeIfPresent(Int.self, forKey: .emojicount)
        imagepath = try values.decodeIfPresent(String.self, forKey: .imagepath)
        user = try values.decodeIfPresent(folderOwner.self, forKey: .user)
        image = try values.decodeIfPresent(ImageShow.self, forKey: .image)
    }

}



struct ImageShow: Codable {
    let id : Int?
    let img_name : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case img_name = "img_name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        img_name = try values.decodeIfPresent(String.self, forKey: .img_name)
    }

}





