//
//  FactCardView.swift
//  Gender
//
//  Created by KavinduDissanayake on 2025-06-20.
//


import SwiftUI

// MARK: - Enhanced Components
struct FactCardView: View {
    let article: FactCheckArticle
    var onShare: (() -> Void)? = nil
    var onRefresh: (() -> Void)? = nil
    var onDelete: (() -> Void)? = nil

    var body: some View {
        VStack(spacing: 0) {
            // Image Section
            RemoteImageView(imageURL: article.imageURL)
            // Content Section
            VStack(alignment: .leading, spacing: 8) {
                Text(article.headline)
                    .font(.headline)
                    .lineLimit(3)
                    .multilineTextAlignment(.leading)
                
                Text(article.dateSaved.formatted(date: .abbreviated, time: .shortened))
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
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
            .padding(.vertical, 8)
            .background(article.factCheckStatus.color)
        }
        .frame(width: 280, height: 280)
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
    }
}

struct RemoteImageView: View {
    let imageURL: String?
    var placeholderSystemImage: String = "newspaper"
    var failureSystemImage: String = "photo"
    var width: CGFloat? = nil
    var height: CGFloat? = nil
    var cornerRadius: CGFloat = 0

    var body: some View {
        Group {
            if let imageURL = imageURL, let url = URL(string: imageURL) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .overlay(ProgressView())
                            .cornerRadius(cornerRadius)
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipped()
                            .cornerRadius(cornerRadius)
                    case .failure:
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .overlay(
                                Image(systemName: failureSystemImage)
                                    .font(.largeTitle)
                                    .foregroundColor(.gray)
                            )
                            .cornerRadius(cornerRadius)
                    @unknown default:
                        EmptyView()
                    }
                }
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                    .overlay(
                        Image(systemName: placeholderSystemImage)
                            .font(.largeTitle)
                            .foregroundColor(.gray)
                    )
                    .cornerRadius(cornerRadius)
            }
        }
        .frame(width: width, height: height)
    }
}



#Preview("FactCardView Variants") {
    ScrollView(.horizontal) {
        HStack(spacing: 16) {
            ForEach(FactCheckStatus.allCases, id: \.self) { status in
                FactCardView(article: FactCheckArticle.mock)
            }
        }
        .padding()
    }
}
