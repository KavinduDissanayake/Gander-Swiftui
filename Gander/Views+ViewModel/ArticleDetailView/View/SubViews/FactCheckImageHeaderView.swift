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
            RemoteImageView(imageURL: imageUrl)
                .frame(height: 200)
                .clipped()

            VStack(alignment: .leading, spacing: 8) {
                Text(headline)
                    .font(.headline)
                    .lineLimit(3)
                    .multilineTextAlignment(.leading)

                Text(date.formatted(date: .abbreviated, time: .shortened))
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)

            HStack {
                Text(status.displayName)
                    .font(.caption)
                    .bold()

                Spacer()

                Image(systemName: status.iconName)
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
    .previewLayout(.sizeThatFits)
}
