//
//  SightingValidator.swift
//  LocalBirds
//
//  Created by Rory Allen on 19/12/2023.
//

import Foundation

struct SightingValidator {
    func validate(_ sighting: NewSighting) throws {
        if sighting.birdId.signum() != 1 {
            throw SightingValidatorError.invalidId
        }
        if sighting.description.isEmpty {
            throw SightingValidatorError.invalidDescription
        }
        if sighting.location.isEmpty {
            throw SightingValidatorError.invalidLocation
        }
    }
}

extension SightingValidator {
    enum SightingValidatorError: LocalizedError {
        case invalidId
        case invalidDescription
        case invalidLocation
    }
}

extension SightingValidator.SightingValidatorError {
    var errorDescription: String? {
        switch self {
        case .invalidId:
            return "BirdId must be a whole number"
        case .invalidDescription:
            return "Description cannot be empty"
        case .invalidLocation:
            return "Location cannot be empty"
        }
    }
}
