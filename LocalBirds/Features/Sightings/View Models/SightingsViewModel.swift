//
//  SightingsViewModel.swift
//  LocalBirds
//
//  Created by Rory Allen on 18/12/2023.
//

import Foundation

final class SightingsViewModel: ObservableObject {
    
    @Published private(set) var sightings: [Sighting] = []
    
    func fetchDetails(for checklistId: String) {
        APINetworkingManager.shared.request("https://nuthatch.lastelm.software/checklists/\(checklistId)/entries", type: SightingsResponse.self) { [weak self] res in
            DispatchQueue.main.async {
                switch res {
                case .success(let result):
                    self?.sightings = result.entities
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
