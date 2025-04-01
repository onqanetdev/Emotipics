//
//  RegisterResponseModel.swift
//  Emotipics
//
//  Created by Onqanet on 01/04/25.
//

import Foundation



struct RegisterResponseModel: Codable {
    let status : Int?
    let success : Bool?
    let message : String?
    let otp : String?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case success = "success"
        case message = "message"
        case otp = "otp"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        otp = try values.decodeIfPresent(String.self, forKey: .otp)
    }

}
