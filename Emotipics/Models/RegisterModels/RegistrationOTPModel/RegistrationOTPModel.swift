//
//  RegistrationOTPModel.swift
//  Emotipics
//
//  Created by Onqanet on 02/04/25.
//

import Foundation



struct RegistrationOTPModel: Codable {
    let status : Int?
    let success : Bool?
    let message : String?
    let login_data : [Login_data]?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case success = "success"
        case message = "message"
        case login_data = "login_data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        login_data = try values.decodeIfPresent([Login_data].self, forKey: .login_data)
    }

}





