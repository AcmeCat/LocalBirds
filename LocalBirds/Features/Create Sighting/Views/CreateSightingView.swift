//
//  CreateSightingView.swift
//  LocalBirds
//
//  Created by Rory Allen on 18/12/2023.
//

import SwiftUI

struct CreateSightingView: View {
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Bird ID", text: .constant(""))
                TextField("Description", text: .constant(""))
                TextField("Location", text: .constant(""))
                
                Section {
                    Button("Submit") {
                        //TODO: Handle
                    }
                }
            }
            .navigationTitle("New Sighting")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    cancel
                }
            }
        }
    }
}

#Preview {
    CreateSightingView()
}

private extension CreateSightingView {
    
    var cancel: some View {
        Button("Cancel") {
            dismiss()
        }
    }
}
