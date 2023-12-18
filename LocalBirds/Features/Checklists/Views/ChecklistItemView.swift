//
//  SightingsListItemView.swift
//  LocalBirds
//
//  Created by Rory Allen on 17/12/2023.
//

import SwiftUI

struct ChecklistItemView: View {
    
    var checklist: Checklist
    
    var body: some View {
        VStack(spacing: .none) {

            VStack (alignment: .leading) {
                
                Text("\(checklist.name)")
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
    ChecklistItemView(checklist: Checklist(name: "Test checklist", id: "an id"))
}
