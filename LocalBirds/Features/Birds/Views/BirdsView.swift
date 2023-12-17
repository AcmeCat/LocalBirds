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
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    create
                }
            }
            .onAppear {
                do {
                    let res = try StaticJSONMapper.decode(file: "BirdsStaticData", type: AllBirdsResponse.self)
                    birds = res.entities
                } catch {
                    //handle errors
                    print(error)
                }
            }
        }
    }
}

#Preview {
    BirdsView()
}

private extension BirdsView {
    
    var create: some View {
        Button {
            
        } label: {
            Symbols.plus
                .font(
                    .system(.headline, design: .rounded)
                    .bold()
                )
        }
    }
    
    
}
