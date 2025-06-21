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
                    .font(.headline)
                    .foregroundColor(.primary)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.bottom, 2)

                Text(article.dateSaved.formatted(date: .abbreviated, time: .shortened))
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding(.horizontal)
            .padding(.top, 8)
            .frame(maxWidth: .infinity, alignment: .leading)

            // Status Section
            HStack {
                Text(article.factCheckStatus.displayName)
                    .font(.caption)
                    .bold()
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
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(radius: 4)
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
                .shadow(radius: 2)
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
