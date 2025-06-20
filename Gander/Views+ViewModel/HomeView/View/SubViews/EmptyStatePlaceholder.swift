//
//  EmptyStatePlaceholder.swift
//  Gender
//
//  Created by KavinduDissanayake on 2025-06-20.
//
import SwiftUI

// MARK: - Empty State Placeholder
struct EmptyStatePlaceholder: View {
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: "doc.text.magnifyingglass")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .foregroundColor(.gray)
            Text("No articles fact-checked yet.")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding()
        .vAlign(.center)

    }
}

#Preview {
    EmptyStatePlaceholder()
}
