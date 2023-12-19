//
//  DetailsViewModel.swift
//  LocalBirds
//
//  Created by Rory Allen on 18/12/2023.
//

import Foundation

final class DetailsViewModel: ObservableObject {
    
    @Published private(set) var birdInfo: SingleBirdResponse?
    @Published private(set) var error: APINetworkingManager.NetworkingError?
    @Published private(set) var isLoading = false
    @Published var hasError = false
    
    func fetchDetails(for birdId: Int) {
        isLoading = true
        APINetworkingManager.shared.request("https://nuthatch.lastelm.software/birds/\(birdId)", type: SingleBirdResponse.self) { [weak self] res in
            DispatchQueue.main.async {
                defer { self?.isLoading = false } //resets loading state after all other processes
                switch res {
                case .success(let result):
                    self?.birdInfo = result
                case .failure(let error):
                    self?.hasError = true
                    self?.error = error as? APINetworkingManager.NetworkingError
                }
            }
        }
    }
}
