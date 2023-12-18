//
//  SightingsItemView.swift
//  LocalBirds
//
//  Created by Rory Allen on 17/12/2023.
//

import SwiftUI

struct SightingsItemView: View {
    
    var sighting: Sighting
    
    var body: some View {
        VStack(spacing: .none) {

            VStack (alignment: .leading) {
                
                Text("BirdId \(sighting.birdID)")
                    .foregroundColor(Theme.text)
                    .font(
                        .system(.headline, design: .rounded)
                    )
                Text("Description \(sighting.description)")
                    .foregroundColor(Theme.text)
                    .font(
                        .system(.headline, design: .rounded)
                    )
                Text("Location \(sighting.location)")
                    .foregroundColor(Theme.text)
                    .font(
                        .system(.headline, design: .rounded)
                    )
            }
            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,
                   alignment: .leading)
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .background(Theme.detailBackground)
        }
        .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        .shadow(color: Theme.text.opacity(0.1), radius: 2, x: 0, y: 1)
    }
}

#Preview {
    SightingsItemView(sighting: Sighting(birdID: "12345", dateTime: "12:00", description: "saw a bird", location: "the place", checklistID: "123-789"))
}
