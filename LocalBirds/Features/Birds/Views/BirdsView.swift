//
//  BirdsView.swift
//  LocalBirds
//
//  Created by Rory Allen on 16/12/2023.
//

import SwiftUI

struct BirdsView: View {
    private let columns = Array(repeating: GridItem(.flexible()),
                                count: 2)
    @State private var birds: [Bird] = []
    
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundView()
                ScrollView {
                    LazyVGrid(columns: columns, 
                              spacing: 16)  {
                        ForEach(birds, id: \.id) { bird in
                            NavigationLink {
                                DetailView()
                            } label: {
                                BirdCardView(bird: bird)
                            }
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Birds")
            .onAppear {
                
                APINetworkingManager.shared.request("https://nuthatch.lastelm.software/v2/birds", type: AllBirdsResponse.self) { res in
                    switch res {
                    case .success(let result):
                        birds = result.entities
                    case .failure(let error):
                        print(error)
                    }
                }
            }
        }
    }
}

#Preview {
    BirdsView()
}


