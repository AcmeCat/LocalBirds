//
//  ChecklistsViewModel.swift
//  LocalBirds
//
//  Created by Rory Allen on 18/12/2023.
//

import Foundation

final class ChecklistsViewModel: ObservableObject {
    
    @Published private(set) var checklists: [Checklist] = []
    
    func fetchChecklists() {
        APINetworkingManager.shared.request("https://nuthatch.lastelm.software/checklists", type: AllChecklistsResponse.self) { [weak self] res in
            DispatchQueue.main.async {
                switch res {
                case .success(let result):
                    self?.checklists = result.entities
                case .failure(let error):
                    print(error)
                }
            }
        }
    }

}
