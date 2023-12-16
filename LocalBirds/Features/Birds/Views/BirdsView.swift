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
    
    var body: some View {
        NavigationView {
            ZStack {
                Theme.background
                    .ignoresSafeArea(edges: .top)
                ScrollView {
                    LazyVGrid(columns: columns, 
                              spacing: 16)  {
                        ForEach(0...5, id: \.self) { item in
                            VStack(spacing: .zero) {
                                Rectangle()
                                    .fill(.blue)
                                    .frame(height: 130)
                                VStack {
                                    Text("#\(item)")
                                        .font(
                                            .system(.caption, design: .rounded)
                                            .bold()
                                        )
                                        .foregroundColor(.white)
                                        .padding(.horizontal, 9)
                                        .padding(.vertical, 4)
                                        .background(Theme.pill, in: Capsule())
                                    Text("<Common Name><Summink>")
                                        .foregroundColor(Theme.text)
                                        .font(
                                            .system(.body, design: .rounded)
                                        )
                                }
                                .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,
                                       alignment: .leading)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 5)
                                .background(Theme.detailBackground)
                            }
                            .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                            .shadow(color: Theme.text.opacity(0.1), radius: 2, x: 0, y: 1)
                        }
                    }
                              .padding()
                }
            }
            .navigationTitle("Birds")
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
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
        }
    }
}

#Preview {
    BirdsView()
}
