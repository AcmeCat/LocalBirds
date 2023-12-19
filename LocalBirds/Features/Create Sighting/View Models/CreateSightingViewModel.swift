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
    
    func create(checklistId: String) {
        
        sighting.birdId = Int(sightingBirdId) ?? 0
        sighting.dateTime = Date.now
        
        do {
            try validator.validate(sighting)
            
            state = .submitting
            
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            encoder.dateEncodingStrategy = .iso8601
            let data = try? encoder.encode(sighting)
            
            APINetworkingManager.shared.request(methodType: .POST(data: data), "https://nuthatch.lastelm.software/checklists/\(checklistId)/entries/\(sighting.birdId)") { [weak self] res in
                
                DispatchQueue.main.async {
                    
                    switch res {
                    case .success:
                        self?.state = .successful
                    case .failure(let err):
                        self?.state = .unsuccessful
                        self?.hasError = true
                        if let networkingError = err as? APINetworkingManager.NetworkingError {
                            self?.error = .networking(error: networkingError)
                        }
                    }
                }
            }
        } catch {
            self.hasError = true
            if let validationError = error as? SightingValidator.SightingValidatorError {
                self.error = .validation(error: validationError)
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
    }
}

extension CreateSightingViewModel.FormError {
    var errorDescription: String? {
        switch self {
        case .networking(let err),
                .validation(let err):
            return err.errorDescription
        }
    }
}
