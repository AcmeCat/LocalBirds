//
//  File.swift
//  LocalBirds
//
//  Created by Rory Allen on 18/12/2023.
//

import Foundation

final class CreateChecklistViewModel: ObservableObject {
    
    @Published var checklist = NewChecklist()
    @Published private(set) var state: SubmissionState?
    @Published private(set) var error: APINetworkingManager.NetworkingError?
    @Published var hasError = false
    
    func create() {
        
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        let data = try? encoder.encode(checklist)
        
        APINetworkingManager.shared.request(methodType: .POST(data: data), "https://nuthatch.lastelm.software/checklists") { [weak self] res in
            
            DispatchQueue.main.async {
                
                switch res {
                case .success:
                    self?.state = .successful
                case .failure(let err):
                    self?.hasError = true
                    self?.error = err as? APINetworkingManager.NetworkingError
                    self?.state = .unsuccessful
                }
            }
        }
    }
}

extension CreateChecklistViewModel {
    enum SubmissionState {
        case unsuccessful
        case successful
    }
}
