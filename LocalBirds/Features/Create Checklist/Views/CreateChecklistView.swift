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
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Checklist Name", text: $vm.checklist.name)
                
                Section {
                    Button("Submit") {
                        vm.create()
                    }
                }
            }
            .navigationTitle("New Checklist")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    cancel
                }
            }
            .onChange(of: vm.state) { formState in
                if formState == .successful {
                    dismiss()
                }
            }
            .alert(isPresented: $vm.hasError, error: vm.error) {
                Button("Retry") {
                    vm.create()
                }
            }
        }
    }
}

#Preview {
    CreateChecklistView()
}

private extension CreateChecklistView {
    
    var cancel: some View {
        Button("Cancel") {
            dismiss()
        }
    }
}
