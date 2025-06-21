//
//  LoginView.swift
//  Gender
//
//  Created by KavinduDissanayake on 2025-06-20.
//
import SwiftUI

// MARK: - Sample Views
struct LoginView: View {
    @AppStorage(CacheKeys.isAuthenticated) private var isAuthenticated: Bool = false

    var body: some View {
        VStack(spacing: 32) {
            Spacer()

            // Center Circle
            ZStack {
                Circle()
                    .fill(Color.primary.opacity(0.05))
                    .frame(width: 200, height: 200)
                Circle()
                    .fill(Color.primary.opacity(0.1))
                    .frame(width: 140, height: 140)
                Circle()
                    .fill(Color.primary.opacity(0.3))
                    .frame(width: 60, height: 60)
            }

            VStack(spacing: 8) {
                Text("Welcome to Gander")
                    .font(.title2.bold())
                    .foregroundColor(Color.primary)

                Text("Your trusted fact-checking buddy for verifying information, checking sources, and ensuring accuracy.")
                    .font(.subheadline)
                    .foregroundColor(Color.secondary)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
            }

            Spacer()

            Button(action: {
                isAuthenticated = true
                ViewRouter.shared.currentRoot = .bottomTabs
            }) {
                HStack {
                    Image(systemName: "applelogo")
                    Text("Continue with Apple")
                        .fontWeight(.semibold)
                }
                .foregroundColor(.black)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.white)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                )
                .padding(.horizontal)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color(.systemBackground).ignoresSafeArea())
    }
}

#Preview {
    LoginView()
}
