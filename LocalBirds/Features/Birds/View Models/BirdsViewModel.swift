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
    
    func fetchBirds() async {
        
        //sets loading state at the beginning and resets it at the end
        isLoading = true
        defer { isLoading = false }
        
        do {
            //try the request and load birds
            let result = try await APINetworkingManager.shared.request(.birds, type: AllBirdsResponse.self)
            self.birds = result.entities
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
