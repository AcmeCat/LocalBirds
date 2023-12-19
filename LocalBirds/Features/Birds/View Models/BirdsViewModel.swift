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
    @Published private(set) var isLoading = false
    @Published var hasError = false
    
    func fetchBirds() {
        isLoading = true
        APINetworkingManager.shared.request("https://nuthatch.lastelm.software/v2/birds", type: AllBirdsResponse.self) { [weak self] res in
            DispatchQueue.main.async {
                defer { self?.isLoading = false }
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
