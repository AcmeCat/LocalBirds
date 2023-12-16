//
//  LocalBirdsApp.swift
//  LocalBirds
//
//  Created by Rory Allen on 15/12/2023.
//

import SwiftUI

@main
struct LocalBirdsApp: App {
    var body: some Scene {
        WindowGroup {
            TabView {
                BirdsView()
                    .tabItem {
                        Symbols.bird
                        Text("Birds")
                    }
            }
        }
    }
}
