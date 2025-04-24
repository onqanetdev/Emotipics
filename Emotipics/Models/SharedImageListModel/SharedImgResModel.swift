//
//  SharedImgResModel.swift
//  Emotipics
//
//  Created by Onqanet on 23/04/25.
//

import Foundation



struct SharedImgResModel:Codable {
    let status : Int?
    let success : Bool?
    let message : String?
    let data : [SharedData]?
    let currentpage : Int?
    let totalpage : Int?
    let path : String?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case success = "success"
        case message = "message"
        case data = "data"
        case currentpage = "currentpage"
        case totalpage = "totalpage"
        case path = "path"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent([SharedData].self, forKey: .data)
        currentpage = try values.decodeIfPresent(Int.self, forKey: .currentpage)
        totalpage = try values.decodeIfPresent(Int.self, forKey: .totalpage)
        path = try values.decodeIfPresent(String.self, forKey: .path)
    }

}


struct SharedData: Codable {
    let id : Int?
    let shared_by : String?
    let image_id : Int?
    let shared_to : String?
    let status : String?
    let created_at : String?
    let updated_at : String?
    let img_name : String?

    enum CodingKeys: String, CodingKey {

        case id = "id"
        case shared_by = "shared_by"
        case image_id = "image_id"
        case shared_to = "shared_to"
        case status = "status"
        case created_at = "created_at"
        case updated_at = "updated_at"
        case img_name = "img_name"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        shared_by = try values.decodeIfPresent(String.self, forKey: .shared_by)
        image_id = try values.decodeIfPresent(Int.self, forKey: .image_id)
        shared_to = try values.decodeIfPresent(String.self, forKey: .shared_to)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
        updated_at = try values.decodeIfPresent(String.self, forKey: .updated_at)
        img_name = try values.decodeIfPresent(String.self, forKey: .img_name)
    }

}
