//
//  GenderApp.swift
//  Gender
//
//  Created by KavinduDissanayake on 2025-06-20.
//

import SwiftUI

@main
struct GenderApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
                .applyViewRoutes()
                .applyMijickPopups()
        }
    }
}
