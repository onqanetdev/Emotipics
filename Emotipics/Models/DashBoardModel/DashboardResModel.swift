//
//  DashboardResModel.swift
//  Emotipics
//
//  Created by Onqanet on 24/04/25.
//

import Foundation


struct DashboardResModel:Codable {
    let status : Int?
    let success : Bool?
    let message : String?
    let total_size : String?
    let remaining_size : String?
    let total_image : Int?
    let total_image_sizeunit : String?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case success = "success"
        case message = "message"
        case total_size = "total_size"
        case remaining_size = "remaining_size"
        case total_image = "total_image"
        case total_image_sizeunit = "total_image_sizeunit"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        success = try values.decodeIfPresent(Bool.self, forKey: .success)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        total_size = try values.decodeIfPresent(String.self, forKey: .total_size)
        remaining_size = try values.decodeIfPresent(String.self, forKey: .remaining_size)
        total_image = try values.decodeIfPresent(Int.self, forKey: .total_image)
        total_image_sizeunit = try values.decodeIfPresent(String.self, forKey: .total_image_sizeunit)
    }

}


