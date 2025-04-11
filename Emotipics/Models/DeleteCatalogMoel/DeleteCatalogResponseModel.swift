//
//  DeleteCatalogResponseModel.swift
//  Emotipics
//
//  Created by Onqanet on 10/04/25.
//

import Foundation



struct DeleteCatalogResponseModel: Codable {
    let success: Bool?
    let message: String?
    let error: Bool?
}
