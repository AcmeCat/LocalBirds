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
    
    @MainActor
    func create() async {
        
        do {
            try validator.validate(checklist)
            
            state = .submitting
            
            let encoder = JSONEncoder()
            encoder.keyEncodingStrategy = .convertToSnakeCase
            let data = try encoder.encode(checklist)
            
            try await APINetworkingManager.shared.request(.createChecklist(submissionData: data))
            
            state = .successful
            
        } catch {
            
            self.hasError = true
            self.state = .unsuccessful
            
            switch error {
            case is APINetworkingManager.NetworkingError:
                self.error = .networking(error: error as! APINetworkingManager.NetworkingError)
            case is ChecklistValidator.ChecklistValidatorError:
                self.error = .validation(error: error as! ChecklistValidator.ChecklistValidatorError)
            default:
                self.error = .system(error: error)
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
        case system(error: Error)
    }
}

extension CreateChecklistViewModel.FormError {
    var errorDescription: String? {
        switch self {
        case .networking(let err),
                .validation(let err):
            return err.errorDescription
        case .system(let err):
            return err.localizedDescription
        }
    }
}
