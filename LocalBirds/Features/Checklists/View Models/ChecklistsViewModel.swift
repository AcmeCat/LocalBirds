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
    
    func fetchChecklists() {
        isLoading = true
        APINetworkingManager.shared.request(.checklists, type: AllChecklistsResponse.self) { [weak self] res in
            DispatchQueue.main.async {
                defer { self?.isLoading = false } //resets loading state after all other processes
                switch res {
                case .success(let result):
                    self?.checklists = result.entities
                case .failure(let error):
                    self?.hasError = true
                    self?.error = error as? APINetworkingManager.NetworkingError
                }
            }
        }
    }

}
