//
//  SuccessPopoverView.swift
//  LocalBirds
//
//  Created by Rory Allen on 19/12/2023.
//

import SwiftUI

struct SuccessPopoverView: View {
    var body: some View {
        Symbols.checkmark
            .font(.system(.largeTitle, design: .rounded).bold())
            .padding()
            .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
    }
}

#Preview {
    SuccessPopoverView()
        .previewLayout(.sizeThatFits)
        .padding()
        .background(.blue)
}
