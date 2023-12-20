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
    @Published private(set) var error: FormError?
    @Published var hasError = false
    
    private let validator = ChecklistValidator()
    
    func create() {
        
        do {
            try validator.validate(checklist)
            
            state = .submitting
            
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            let data = try? encoder.encode(checklist)
            
            APINetworkingManager.shared.request(.createChecklist(submissionData: data)) { [weak self] res in
                
                DispatchQueue.main.async {
                    
                    switch res {
                    case .success:
                        self?.state = .successful
                    case .failure(let err):
                        self?.state = .unsuccessful
                        self?.hasError = true
                        if let networkingError = err as? APINetworkingManager.NetworkingError {
                            self?.error = .networking(error: networkingError)
                        }
                    }
                }
            }
        } catch {
            self.hasError = true
            if let validationError = error as? ChecklistValidator.ChecklistValidatorError {
                self.error = .validation(error: validationError)
            }
        }
        
    }
}

extension CreateChecklistViewModel {
    enum SubmissionState {
        case unsuccessful
        case successful
        case submitting
    }
}

extension CreateChecklistViewModel {
    enum FormError: LocalizedError {
        case networking(error: LocalizedError)
        case validation(error: LocalizedError)
    }
}

extension CreateChecklistViewModel.FormError {
    var errorDescription: String? {
        switch self {
        case .networking(let err),
                .validation(let err):
            return err.errorDescription
        }
    }
}
