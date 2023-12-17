//
//  BackgroundView.swift
//  LocalBirds
//
//  Created by Rory Allen on 17/12/2023.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        Theme.background
            .ignoresSafeArea(edges: .top)
    }
}

#Preview {
    BackgroundView()
}
