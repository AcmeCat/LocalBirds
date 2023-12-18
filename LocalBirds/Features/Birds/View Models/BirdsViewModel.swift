//
//  BirdsViewModel.swift
//  LocalBirds
//
//  Created by Rory Allen on 18/12/2023.
//

import Foundation

final class BirdsViewModel: ObservableObject {
    
    @Published private(set) var birds: [Bird] = []
    
    func fetchBirds() {
        APINetworkingManager.shared.request("https://nuthatch.lastelm.software/v2/birds", type: AllBirdsResponse.self) { [weak self] res in
            switch res {
            case .success(let result):
                self?.birds = result.entities
            case .failure(let error):
                print(error)
            }
        }

    }
}
