//
//  RemoteImageView.swift
//  Gender
//
//  Created by KavinduDissanayake on 2025-06-20.
//
import SwiftUI

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
                            .aspectRatio(contentMode: .fit)
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

// MARK: - Preview
#Preview {
    VStack(spacing: 20) {
        RemoteImageView(imageURL: "https://via.placeholder.com/150", width: 150, height: 150, cornerRadius: 12)
        
        RemoteImageView(imageURL: nil, width: 150, height: 150, cornerRadius: 12)
        
        RemoteImageView(imageURL: "invalid_url", width: 150, height: 150, cornerRadius: 12)
    }
    .padding()
}
