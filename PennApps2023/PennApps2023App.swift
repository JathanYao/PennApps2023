//
//  PennApps2023App.swift
//  PennApps2023
//
//  Created by Owen Guo on 2023-09-08.
//

import SwiftUI

@main
struct PennApps2023App: App {
    @StateObject private var globalData = gv()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(globalData)
        }
    }
}
