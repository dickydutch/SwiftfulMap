//
//  SwiftfulMapApp.swift
//  SwiftfulMap
//
//  Created by Richard Holland on 13/07/2025.
//

import SwiftUI

@main
struct SwiftfulMapApp: App {
    
    @StateObject private var vm = LocationsViewModel()
    
    var body: some Scene {
        WindowGroup {
            LocationsView()
                .environmentObject(vm)
        }
    }
}
