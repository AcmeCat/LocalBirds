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
    
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundView()
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
            .navigationTitle("Birds")
            .onAppear {
                vm.fetchBirds()
            }
            .alert(isPresented: $vm.hasError, error: vm.error) {
                Button("Retry") {
                    vm.fetchBirds()
                }
            }
        }
    }
}

#Preview {
    BirdsView()
}


