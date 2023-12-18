//
//  SightingsView.swift
//  LocalBirds
//
//  Created by Rory Allen on 17/12/2023.
//

import SwiftUI

struct SightingsView: View {
    
    @State private var sightings: [Sighting] = []
    @State private var shouldShowCreate = false
    
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundView()
                ScrollView {
                    VStack {
                        ForEach (sightings, id: \.birdID) { sighting in
                            
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
                do {
                    let res = try StaticJSONMapper.decode(file: "SightingsData", type: SightingsResponse.self)
                    sightings = res.entities
                } catch {
                    //handle errors
                    print(error)
                }
            }
            .sheet(isPresented: $shouldShowCreate) {
                CreateSightingView()
            }
        }
    }
}

#Preview {
    SightingsView()
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
