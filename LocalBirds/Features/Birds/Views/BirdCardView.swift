//
//  BirdCardView.swift
//  LocalBirds
//
//  Created by Rory Allen on 16/12/2023.
//

import SwiftUI

struct BirdCardView: View {
    
    let bird: Int
    
    var body: some View {
        VStack(spacing: .zero) {
            Rectangle()
                .fill(.blue)
                .frame(height: 130)
            VStack (alignment: .leading) {
                
                PillView(id: bird)
                
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

#Preview {
    BirdCardView(bird: 0)
        .frame(width: 200
        )
}
