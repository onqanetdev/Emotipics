//
//  ProfileDetailsResModel.swift
//  Emotipics
//
//  Created by Onqanet on 02/05/25.
//

import Foundation



struct ProfileDetailsResModel: Codable {
    let success : Bool?
    let user : User?

    enum CodingKeys: String, CodingKey {

        case success = "success"
        case user = "user"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        user = try values.decodeIfPresent(User.self, forKey: .user)
    }

}
