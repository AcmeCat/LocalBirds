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
    
    @StateObject private var vm = BirdsViewModel()
    @State private var hasAppeared = false
    
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundView()
                
                if vm.isLoading {
                    ProgressView()
                } else {
                    ScrollView {
                        LazyVGrid(columns: columns,
                                  spacing: 16)  {
                            ForEach(vm.birds, id: \.id) { bird in
                                NavigationLink {
                                    DetailView(birdId: bird.id)
                                } label: {
                                    BirdCardView(bird: bird)
                                }
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationTitle("Birds")
            .task {
                if !hasAppeared {
                    await vm.fetchBirds()
                    hasAppeared = true
                }
            }
            .alert(isPresented: $vm.hasError, error: vm.error) {
                Button("Retry") {
                    Task {
                        await vm.fetchBirds()
                    }
                }
            }
        }
        .onAppear {
            URLCache.shared.memoryCapacity = 1024 * 1024 * 128
        }
    }
}

#Preview {
    BirdsView()
}


