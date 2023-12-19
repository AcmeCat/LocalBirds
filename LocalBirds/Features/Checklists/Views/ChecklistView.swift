//
//  ChecklistView.swift
//  LocalBirds
//
//  Created by Rory Allen on 16/12/2023.
//

import SwiftUI

struct ChecklistView: View {
    
    @StateObject private var vm = ChecklistsViewModel()
    @State private var shouldShowCreate = false
    
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundView()
                if vm.isLoading {
                    ProgressView()
                } else {
                    ScrollView {
                        VStack {
                            ForEach (vm.checklists, id: \.id) { checklist in
                                NavigationLink {
                                    SightingsView(checklistId: checklist.id)
                                } label: {
                                    ChecklistItemView(checklist: checklist)
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Checklists")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    create
                }
            }
            .onAppear {
                vm.fetchChecklists()
            }
            .alert(isPresented: $vm.hasError, error: vm.error) {
                Button("Retry") {
                    vm.fetchChecklists()
                }
            }
            .sheet(isPresented: $shouldShowCreate, onDismiss: fetch){
                CreateChecklistView()
            }
        }
    }
}

#Preview {
    ChecklistView()
}

private extension ChecklistView {
    
    var create: some View {
        Button {
            shouldShowCreate.toggle()
        } label: {
            Symbols.plus
                .font(
                    .system(.headline, design: .rounded)
                    .bold()
                )
        }
    }
    
    func fetch() {
        vm.fetchChecklists()
    }
    
}
