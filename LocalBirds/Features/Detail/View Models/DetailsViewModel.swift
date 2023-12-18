//
//  DetailsViewModel.swift
//  LocalBirds
//
//  Created by Rory Allen on 18/12/2023.
//

import Foundation

final class DetailsViewModel: ObservableObject {
    
    @Published private(set) var birdInfo: SingleBirdResponse?
    
    func fetchDetails(for birdId: Int) {
        APINetworkingManager.shared.request("https://nuthatch.lastelm.software/birds/\(birdId)", type: SingleBirdResponse.self) { [weak self] res in
            DispatchQueue.main.async {
                switch res {
                case .success(let result):
                    self?.birdInfo = result
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
