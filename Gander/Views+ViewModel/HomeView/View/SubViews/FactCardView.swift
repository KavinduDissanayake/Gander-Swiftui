//
//  FactCardView.swift
//  Gender
//
//  Created by KavinduDissanayake on 2025-06-20.
//
import WaterfallGrid
import SwiftUI

// MARK: - Enhanced Components
struct FactCardView: View {
    let article: FactCheckArticle
    var onShare: (() -> Void)?
    var onRefresh: (() -> Void)?
    var onDelete: (() -> Void)?
    var onTap: (() -> Void)?

    var body: some View {
        VStack(spacing: 0) {

            // Image Section
            RemoteImageView(imageURL: article.imageURL, cornerRadius: 0)
                .aspectRatio(contentMode: .fill)
                .frame(height: 140)
                .clipped()

            // Content Section
            VStack(alignment: .leading, spacing: 6) {
                Text(article.headline)
                    .fontSemiBold(17)
                    .foregroundColor(.primary)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.bottom, 2)

                Text(article.dateSaved.formatted(date: .abbreviated, time: .shortened))
                    .fontRegular(12)
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal)
            .padding(.top, 8)

            // Status Section
            HStack {
                Text(article.factCheckStatus.displayName)
                    .fontSemiBold(12)
                    .foregroundColor(.white)

                Spacer()

                Image(systemName: article.factCheckStatus.iconName)
                    .foregroundColor(.white)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(article.factCheckStatus.color)
        }
        .frame(minWidth: 170)
        .background(.lightBackgroundGray)
        .cornerRadius(16)
        .contextMenu {
            Button {
                onShare?()
            } label: {
                Label("Share", systemImage: "square.and.arrow.up")
            }

            Button {
                onRefresh?()
            } label: {
                Label("Refresh", systemImage: "arrow.clockwise")
            }

            Button(role: .destructive) {
                onDelete?()
            } label: {
                Label("Delete", systemImage: "trash")
            }
        }
        .onTapGesture {
            onTap?()
        }
    }

}

#Preview("FactCardView Variants") {
    ScrollView {
        WaterfallGrid(FactCheckStatus.allCases, id: \.self) { _ in
            FactCardView(article: FactCheckArticle.mock)
                .frame(width: 180)
                .background(Color.white)
                .cornerRadius(12)
        }
        .gridStyle(
            columnsInPortrait: 2,
            columnsInLandscape: 4,
            spacing: 16,
            animation: .default
        )
        .padding()
    }
}
