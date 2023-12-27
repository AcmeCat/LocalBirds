//
//  BirdCardView.swift
//  LocalBirds
//
//  Created by Rory Allen on 16/12/2023.
//

import SwiftUI

struct BirdOfTheDayView: View {
    
    @Binding var shouldShowBOTD: Bool
    let bird: Bird
    
    var body: some View {
        VStack {
            HStack {
                Text("Bird Of The Day")
                    .foregroundColor(Theme.text)
                    .font(
                        .system(.title3, design: .rounded)
                    )
                    .padding(.horizontal, 8)
                    .padding(.vertical, 15)
                Spacer()
                exit
            }
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/)
            .background(Theme.detailBackground)
            
            NavigationLink {
                DetailView(birdId: bird.id)
            } label: {
                VStack(spacing: .zero) {
                    AsyncImage(url: .init(string: bird.images.first ?? "https://images.unsplash.com/photo-1643650997626-0124dbb98261")) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(height: 300)
                            .clipped()
                    } placeholder: {
                        ProgressView()
                    }
                    VStack (alignment: .leading) {
                        
                        PillView(id: bird.id)
                        
                        Text("\(bird.name)")
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
    }
}

#Preview {
        
    BirdCardView(bird: Bird(images: [], region: [], lengthMin: "21", lengthMax: "22", name: "Hello", sciName: "Hellous", family: "Allens", order: "AndLaw", status: "Real Cool", id: 23)).frame(width: 200)
}

private extension BirdOfTheDayView {
    
    var exit: some View {
        Button {
            withAnimation {
                shouldShowBOTD = false
            }
        } label: {
            Image(systemName: "xmark.circle")
                .font(.title3)
                .foregroundColor(.blue)
        }
        .padding()

    }
    
}
