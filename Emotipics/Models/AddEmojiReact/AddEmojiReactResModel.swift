//
//  AddEmojiReactResModel.swift
//  Emotipics
//
//  Created by Onqanet on 06/05/25.
//

import Foundation





struct AddEmojiReactResModel: Codable {
    let status : Int?
    let success : Bool?
    let message : String?
    let data : EmojiReactData?

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
        data = try values.decodeIfPresent(EmojiReactData.self, forKey: .data)
    }

}


struct EmojiReactData: Codable {
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
    let imagesize : String?
    let path : String?
    let emoji : [Emoji]?
    let emojicount : Int?
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
        case imagesize = "imagesize"
        case path = "path"
        case emoji = "emoji"
        case emojicount = "emojicount"
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
        imagesize = try values.decodeIfPresent(String.self, forKey: .imagesize)
        path = try values.decodeIfPresent(String.self, forKey: .path)
        emoji = try values.decodeIfPresent([Emoji].self, forKey: .emoji)
        emojicount = try values.decodeIfPresent(Int.self, forKey: .emojicount)
        user = try values.decodeIfPresent(folderOwner.self, forKey: .user)
    }

}


struct Emoji: Codable {
    let emoji_code : String?

    enum CodingKeys: String, CodingKey {

        case emoji_code = "emoji_code"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        emoji_code = try values.decodeIfPresent(String.self, forKey: .emoji_code)
    }

}








