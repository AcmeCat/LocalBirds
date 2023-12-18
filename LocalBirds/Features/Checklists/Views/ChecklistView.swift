//
//  ChecklistView.swift
//  LocalBirds
//
//  Created by Rory Allen on 16/12/2023.
//

import SwiftUI

struct ChecklistView: View {
    
    @State private var checklists: [Checklist] = []
    @State private var shouldShowCreate = false
    
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundView()
                ScrollView {
                    VStack {
                        ForEach (checklists, id: \.id) { checklist in
                            NavigationLink {
                                SightingsView()
                            } label: {
                                ChecklistItemView(checklist: checklist)
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Checklists")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    create
                }
            }
            .onAppear {
                do {
                    let res = try StaticJSONMapper.decode(file: "ChecklistsData", type: AllChecklistsResponse.self)
                    checklists = res.entities
                } catch {
                    //handle errors
                    print(error)
                }
            }
            .sheet(isPresented: $shouldShowCreate) {
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
    
    
}
