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
    @Published private(set) var error: APINetworkingManager.NetworkingError?
    @Published var hasError = false
    
    func create(checklistId: String) {
        
        state = .submitting
        
        sighting.birdId = Int(sightingBirdId) ?? 0
        sighting.dateTime = Date.now
        
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
                    self?.hasError = true
                    self?.error = err as? APINetworkingManager.NetworkingError
                    self?.state = .unsuccessful
                }
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
