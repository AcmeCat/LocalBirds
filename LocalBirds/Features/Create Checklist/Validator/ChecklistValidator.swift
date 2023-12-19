//
//  ChecklistValidator.swift
//  LocalBirds
//
//  Created by Rory Allen on 19/12/2023.
//

import Foundation

struct ChecklistValidator {
    func validate(_ checklist: NewChecklist) throws {
        if checklist.name.isEmpty {
            throw ChecklistValidatorError.invalidName
        }
    }
}

extension ChecklistValidator {
    enum ChecklistValidatorError: LocalizedError {
        case invalidName
    }
}

extension ChecklistValidator.ChecklistValidatorError {
    var errorDescription: String? {
        switch self {
        case .invalidName:
            return "Checklist name cannot be empty"
        }
    }
}
