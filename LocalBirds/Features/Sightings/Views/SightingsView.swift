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
    
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundView()
                ScrollView {
                    VStack {
                        ForEach (vm.sightings, id: \.birdID) { sighting in
                            
                                SightingsItemView(sighting: sighting)
                            
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Sightings")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    create
                }
            }
            .onAppear {
                vm.fetchDetails(for: checklistId)
            }
            .sheet(isPresented: $shouldShowCreate) {
                CreateSightingView()
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
    
    
}
