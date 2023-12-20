//
//  CreateSightingViewModel.swift
//  LocalBirds
//
//  Created by Rory Allen on 18/12/2023.
//

import Foundation

final class CreateSightingViewModel: ObservableObject {
    
    @Published var sighting = NewSighting()
    @Published var sightingBirdId: String = "0"
    
    @Published private(set) var state: SubmissionState?
    @Published private(set) var error: FormError?
    @Published var hasError = false
    
    private let validator = SightingValidator()
    
    func create(checklistId: String) async {
        
        sighting.birdId = Int(sightingBirdId) ?? 0
        sighting.dateTime = Date.now
        
        do {
            try validator.validate(sighting)
            
            state = .submitting
            
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            encoder.dateEncodingStrategy = .iso8601
            let data = try? encoder.encode(sighting)
            
            try await APINetworkingManager.shared.request(.createSighting(checklistId: checklistId, birdId: sighting.birdId, submissionData: data))
            
            state = .successful
            
        } catch {
            
            self.hasError = true
            self.state = .unsuccessful
            
            switch error {
            case is APINetworkingManager.NetworkingError:
                self.error = .networking(error: error as! APINetworkingManager.NetworkingError)
            case is SightingValidator.SightingValidatorError:
                self.error = .validation(error: error as! SightingValidator.SightingValidatorError)
            default:
                self.error = .system(error: error)
            }
        }
    }
}

extension CreateSightingViewModel {
    enum SubmissionState {
        case unsuccessful
        case successful
        case submitting
    }
}

extension CreateSightingViewModel {
    enum FormError: LocalizedError {
        case networking(error: LocalizedError)
        case validation(error: LocalizedError)
        case system(error: Error)
    }
}

extension CreateSightingViewModel.FormError {
    var errorDescription: String? {
        switch self {
        case .networking(let err),
                .validation(let err):
            return err.errorDescription
        case .system(let err):
            return err.localizedDescription
        }
    }
}
