//
//  ChecklistView.swift
//  LocalBirds
//
//  Created by Rory Allen on 16/12/2023.
//

import SwiftUI

struct ChecklistView: View {
    var body: some View {
        NavigationView {
            ZStack {
                BackgroundView()
                ScrollView {
                    VStack {
                        ForEach (0...5, id: \.self) { item in
                            Text("\(item)")
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ChecklistView()
}
