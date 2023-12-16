//
//  SingleBirdResponse.swift
//  LocalBirds
//
//  Created by Rory Allen on 16/12/2023.
//

import Foundation

// MARK: - SingleBirdResponse
struct SingleBirdResponse: Codable {
    let images, region: [String]
    let lengthMin, lengthMax, name, sciName, family, order, status: String
    let id: Int
    let recordings: [Recording]
}

// MARK: - Recording
struct Recording: Codable {
    let date, loc, lat, lng: String
    let birdId: Int
}
