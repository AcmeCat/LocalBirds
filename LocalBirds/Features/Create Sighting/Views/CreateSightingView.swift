//
//  CreateSightingView.swift
//  LocalBirds
//
//  Created by Rory Allen on 18/12/2023.
//

import SwiftUI

struct CreateSightingView: View {
    
    let checklistId: String
    @Environment(\.dismiss) private var dismiss
    @StateObject private var vm = CreateSightingViewModel()
    let successfulAction: () -> Void
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Bird ID", text: $vm.sightingBirdId)
                TextField("Description", text: $vm.sighting.description)
                TextField("Location", text: $vm.sighting.location)
                
                Section {
                    Button("Submit") {
                        vm.create(checklistId: checklistId)
                    }
                }
            }
            .disabled(vm.state == .submitting)
            .navigationTitle("New Sighting")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    cancel
                }
            }
            .onChange(of: vm.state) { formState in
                if formState == .successful {
                    dismiss()
                    successfulAction()
                }
            }
            .alert(isPresented: $vm.hasError, error: vm.error) {
                Button("Retry") {
                    vm.create(checklistId: checklistId)
                }
            }
            .overlay {
                if vm.state == .submitting {
                    ProgressView()
                }
            }
        }
    }
}

#Preview {
    CreateSightingView(checklistId: "0") {}
}

private extension CreateSightingView {
    
    var cancel: some View {
        Button("Cancel") {
            dismiss()
        }
    }
}
