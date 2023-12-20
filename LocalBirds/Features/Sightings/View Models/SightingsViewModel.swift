//
//  SightingsViewModel.swift
//  LocalBirds
//
//  Created by Rory Allen on 18/12/2023.
//

import Foundation

final class SightingsViewModel: ObservableObject {
    
    @Published private(set) var sightings: [Sighting] = []
    @Published private(set) var error: APINetworkingManager.NetworkingError?
    @Published private(set) var isLoading = false
    @Published var hasError = false
    
    func fetchDetails(for checklistId: String) async {
        
        //sets loading state at the beginning and resets it at the end
        isLoading = true
        defer { isLoading = false }
        
        do {
            //try the request and load bird details
            let result = try await APINetworkingManager.shared.request(.sightings(checklistId: checklistId), type: SightingsResponse.self)
            self.sightings = result.entities
        } catch {
            //handle errors
            self.hasError = true
            if let networkingError = error as? APINetworkingManager.NetworkingError {
                self.error = networkingError
            } else {
                self.error = .custom(error: error)
            }
        }
    }
}
