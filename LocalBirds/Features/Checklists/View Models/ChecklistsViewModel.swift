//
//  ChecklistsViewModel.swift
//  LocalBirds
//
//  Created by Rory Allen on 18/12/2023.
//

import Foundation

final class ChecklistsViewModel: ObservableObject {
    
    @Published private(set) var checklists: [Checklist] = []
    @Published private(set) var error: APINetworkingManager.NetworkingError?
    @Published private(set) var isLoading = false
    @Published var hasError = false
    
    func fetchChecklists() async {
        
        //sets loading state at the beginning and resets it at the end
        isLoading = true
        defer { isLoading = false }
        
        do {
            //try the request and load bird details
            let result = try await APINetworkingManager.shared.request(.checklists, type: AllChecklistsResponse.self)
            self.checklists = result.entities
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
