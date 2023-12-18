//
//  NewSighting.swift
//  LocalBirds
//
//  Created by Rory Allen on 18/12/2023.
//

import Foundation

struct NewSighting: Codable {
    var birdId: Int = 0
    var description: String = ""
    var dateTime: Date = Date.now
    var location: String = ""
    
    enum CodingKeys: String, CodingKey {
        case birdId, description, location
        case dateTime = "date-time"
    }
}
