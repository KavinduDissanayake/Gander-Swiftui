//
//  SourceRowView.swift
//  Gander
//
//  Created by Kavindu Dissanayake on 2025-06-20.
//


import SwiftUI

struct SourceRowView: View {
    let source: FactSource

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            RemoteImageView(imageURL: source.sourceImageURL ?? "", cornerRadius: 30)
                .frame(width: 32, height: 32)

            VStack(alignment: .leading, spacing: 4) {
                Text(source.title ?? "Unknown Title")
                    .font(.subheadline)
                    .fontWeight(.semibold)

                Text(source.date ?? "")
                    .font(.caption)
                    .foregroundColor(.gray)
            }

            Spacer()

            RemoteImageView(imageURL: source.thumbnailImageURL ?? "", cornerRadius: 4)
                .frame(width: 32, height: 32)
        }
    }
}
