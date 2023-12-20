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
    @State private var shouldShowSuccess = false
    
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
            .task {
                await vm.fetchChecklists()
            }
            .sheet(isPresented: $shouldShowCreate, onDismiss: fetch){
                CreateChecklistView {
                    haptic(.success)
                    withAnimation(.spring().delay(0.25)) {
                        self.shouldShowSuccess.toggle()
                    }
                }
            }
            .alert(isPresented: $vm.hasError, error: vm.error) {
                Button("Retry") {
                    Task {
                        await vm.fetchChecklists()
                    }
                }
            }
            .overlay {
                if shouldShowSuccess {
                    SuccessPopoverView()
                        .transition(.scale.combined(with: .opacity))
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                                withAnimation(.spring()) {
                                    self.shouldShowSuccess.toggle()
                                }
                            }
                        }
                }
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
    
    func fetch() { Task { await vm.fetchChecklists() }}
    
}
