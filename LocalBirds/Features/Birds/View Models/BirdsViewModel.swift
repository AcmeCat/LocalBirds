//
//  BirdsViewModel.swift
//  LocalBirds
//
//  Created by Rory Allen on 18/12/2023.
//

import Foundation

final class BirdsViewModel: ObservableObject {
    
    @Published private(set) var birds: [Bird] = []
    @Published private(set) var error: APINetworkingManager.NetworkingError?
    @Published var hasError = false
    
    func fetchBirds() {
        APINetworkingManager.shared.request("https://nuthatch.lastelm.software/v2/birds", type: AllBirdsResponse.self) { [weak self] res in
            DispatchQueue.main.async {
                switch res {
                case .success(let result):
                    self?.birds = result.entities
                case .failure(let error):
                    self?.hasError = true
                    self?.error = error as? APINetworkingManager.NetworkingError
                }
            }
        }
    }
}
