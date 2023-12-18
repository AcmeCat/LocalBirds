//
//  SightingsResponse.swift
//  LocalBirds
//
//  Created by Rory Allen on 17/12/2023.
//

import Foundation


// MARK: - SightingsList
struct SightingsResponse: Codable {
    let entities: [Sighting]
    let total, page, pageSize: Int
}

// MARK: - Entity
struct Sighting: Codable {
    let birdID, dateTime, description, location: String
    let checklistID: String

    enum CodingKeys: String, CodingKey {
        case birdID = "birdId"
        case dateTime = "date-time"
        case description, location
        case checklistID = "checklistId"
    }
}
