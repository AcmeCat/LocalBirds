//
//  CreateChecklistView.swift
//  LocalBirds
//
//  Created by Rory Allen on 17/12/2023.
//

import SwiftUI

struct CreateChecklistView: View {
    
    @Environment(\.dismiss) private var dismiss
    @StateObject private var vm = CreateChecklistViewModel()
    let successfulAction: () -> Void
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Checklist Name", text: $vm.checklist.name)
                } footer: {
                    if case .validation(let err) = vm.error,
                       let errorDesc = err.errorDescription {
                        Text(errorDesc)
                            .foregroundStyle(.red)
                    }
                }
                
                Section {
                    Button("Submit") {
                        vm.create()
                    }
                }
            }
            .disabled(vm.state == .submitting)
            .navigationTitle("New Checklist")
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
                    vm.create()
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
    CreateChecklistView() {}
}

private extension CreateChecklistView {
    
    var cancel: some View {
        Button("Cancel") {
            dismiss()
        }
    }
}
