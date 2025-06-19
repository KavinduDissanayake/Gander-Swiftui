//
//  LoginView.swift
//  Gender
//
//  Created by KavinduDissanayake on 2025-06-20.
//
import SwiftUI

// MARK: - Sample Views
struct LoginView: View {
    var body: some View {
        VStack {
            Text("Login View")
                .font(.largeTitle)
                .padding()
            Button("Go to Home") {
                ViewRouter.shared.currentRoot = .home
            }
        }
    }
}
