//
//  GroupImageDeleteResModel.swift
//  Emotipics
//
//  Created by Onqanet on 05/05/25.
//

import Foundation




struct GroupImageDeleteResModel: Codable {
    let status : Int?
    let success : Bool?
    let message : String?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case success = "success"
        case message = "message"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        message = try values.decodeIfPresent(String.self, forKey: .message)
    }

}


