//
//  FactCheckImageHeaderView.swift
//  Gender
//
//  Created by KavinduDissanayake on 2025-06-20.
//
import SwiftUI

struct FactCheckImageHeaderView: View {
    let imageUrl: String?
    let headline: String
    let date: Date
    let status: FactCheckStatus

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                RemoteImageView(imageURL: imageUrl,
                                cornerRadius: 12,
                                roundedCorners: [.topLeft, .topRight]

                )

                LinearGradient(
                    gradient: Gradient(colors: [.black, .black.opacity(0)]),
                    startPoint: .bottom, endPoint: .top
                )
                .frame(height: 160)
                .vAlign(.bottom)

                Text(headline)
                    .font(.headline)
                    .lineLimit(3)
                    .multilineTextAlignment(.leading)
                    .foregroundStyle(.white)
                    .vAlign(.bottom)
                    .padding()
            }
            .frame(height: 240)

            HStack {
                Text(status.displayName)
                    .fontRegular(12)
                    .foregroundStyle(.white)
                    .bold()

                Spacer()

                Image(systemName: status.iconName)
                    .foregroundStyle(.white)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(status.color)
        }
        .cornerRadius(12)
    }
}

#Preview("FactCheckImageHeaderView") {
    FactCheckImageHeaderView(
        imageUrl: "https://example.com/sample.jpg",
        headline: "Sample Headline for Testing FactCheckImageHeaderView",
        date: Date(),
        status: .verified
    )
    .padding()
}
