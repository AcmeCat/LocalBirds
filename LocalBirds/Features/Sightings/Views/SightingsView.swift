//
//  SightingsView.swift
//  LocalBirds
//
//  Created by Rory Allen on 17/12/2023.
//

import SwiftUI

struct SightingsView: View {
    
    let checklistId: String
    @StateObject private var vm = SightingsViewModel()
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
                            ForEach (vm.sightings, id: \.birdID) { sighting in
                                
                                SightingsItemView(sighting: sighting)
                                
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Sightings")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    create
                }
            }
            .task {
                await vm.fetchDetails(for: checklistId)
            }
            .sheet(isPresented: $shouldShowCreate, onDismiss: fetch){
                CreateSightingView(checklistId: checklistId) {
                    haptic(.success)
                    withAnimation(.spring().delay(0.25)) {
                        self.shouldShowSuccess.toggle()
                    }
                }
            }
            .alert(isPresented: $vm.hasError, error: vm.error) {
                Button("Retry") {
                    Task {
                        await vm.fetchDetails(for: checklistId)
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
    SightingsView(checklistId: "")
}

private extension SightingsView {
    
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
    
    func fetch(){ Task { await vm.fetchDetails(for: checklistId) } }
    
}
