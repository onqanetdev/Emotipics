//
//  AddBirthdayResModel.swift
//  Emotipics
//
//  Created by Onqanet on 26/05/25.
//

import Foundation




struct AddBirthdayResModel: Codable {
    let status : Int?
    let success : Bool?
    let message : String?
   // let data : BirthData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case success = "success"
        case message = "message"
       // case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        //data = try values.decodeIfPresent(BirthData.self, forKey: .data)
    }

}

struct BirthData: Codable {
    let message : String?
    let type : String?
    let user_codes : String?
    let user_read_code : Int?
    let code : Int?
    let image_url : String?
    let notification_date : String?
    let status : Int?
    let updated_at : String?
    let created_at : String?
    let id : Int?

    enum CodingKeys: String, CodingKey {

        case message = "message"
        case type = "type"
        case user_codes = "user_codes"
        case user_read_code = "user_read_code"
        case code = "code"
        case image_url = "image_url"
        case notification_date = "notification_date"
        case status = "status"
        case updated_at = "updated_at"
        case created_at = "created_at"
        case id = "id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        user_codes = try values.decodeIfPresent(String.self, forKey: .user_codes)
        user_read_code = try values.decodeIfPresent(Int.self, forKey: .user_read_code)
        code = try values.decodeIfPresent(Int.self, forKey: .code)
        image_url = try values.decodeIfPresent(String.self, forKey: .image_url)
        notification_date = try values.decodeIfPresent(String.self, forKey: .notification_date)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
    }

}
