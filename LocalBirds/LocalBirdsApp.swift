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
                MainView()
                    .tabItem {
                        Symbols.list
                        Text("Checklists")
                    }
                BirdsView()
                    .tabItem {
                        Symbols.bird
                        Text("Birds")
                    }
                SettingsView()
                    .tabItem {
                        Symbols.gear
                        Text("Settings")
                    }
            }
        }
    }
}
