//
//  AllBirdsResponse.swift
//  LocalBirds
//
//  Created by Rory Allen on 16/12/2023.
//

import Foundation


// MARK: - AllBirdsResponse
struct AllBirdsResponse: Codable {
    let entities: [Bird]
    let total, page, pageSize: Int
}

// MARK: - Entity
struct Bird: Codable {
    let images, region: [String]
    let lengthMin, lengthMax, name, sciName, family, order, status: String
    let id: Int
}
