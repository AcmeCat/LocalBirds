//
//  CreateChecklistView.swift
//  LocalBirds
//
//  Created by Rory Allen on 17/12/2023.
//

import SwiftUI

struct CreateChecklistView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Checklist Name", text: .constant(""))
                
                Section {
                    Button("Submit") {
                        //TODO: Handle
                    }
                }
            }
            .navigationTitle("New Checklist")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    cancel
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
