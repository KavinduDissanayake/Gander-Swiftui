//
//  HomeView.swift
//  Gender
//
//  Created by KavinduDissanayake on 2025-06-20.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        VStack {
            Text("Home View")
                .font(.largeTitle)
                .padding()
            Button("Log Out") {
                ViewRouter.shared.currentRoot = .login
            }
        }
    }
}
