//
//  SourcesView.swift
//  Gender
//
//  Created by KavinduDissanayake on 2025-06-20.
//

import SwiftUI

struct SourcesView: View {
    let sources: [FactSource]
    private let maxDisplay = 3
    @State private var selectedURL: URL?
    @State private var isActive = false

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Sources")
                .fontSemiBold(17)

            ForEach(sources.prefix(maxDisplay), id: \.url) { source in
                Button {
                    if let urlString = source.url, let url = URL(string: urlString) {
                        selectedURL = url
                        isActive = true
                    }
                } label: {
                    SourceRowView(source: source)
                        .contentShape(Rectangle())
                }
            }

            if sources.count > maxDisplay {
                HStack(spacing: 8) {
                    Text("Other Sources")
                        .fontMedium(15)
                        .fontWeight(.semibold)
                        .foregroundColor(.primary)

                    let otherSources = sources.suffix(from: maxDisplay).prefix(3)
                    ForEach(Array(otherSources.enumerated()), id: \.offset) { index, source in

                        Button {
                            if let urlString = source.url, let url = URL(string: urlString) {
                                selectedURL = url
                                isActive = true
                            }
                        } label: {
                            SourceIconBadge(imageURL: source.sourceImageURL ?? "", index: index)
                                .contentShape(Rectangle())
                        }
                    }

//                    if sources.count > maxDisplay + 3 {
//                        Image(systemName: "plus")
//                            .foregroundColor(.primary)
//                    }
                }
                .padding(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.primary.opacity(0.1), lineWidth: 1)
                )
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(.top, 8)
            }
        }
        .navigate(
            to: InAppWebView(url: selectedURL),
            when: $isActive
        )
    }
}

struct SourceIconBadge: View {
    let imageURL: String
    let index: Int

    var body: some View {
        VStack(spacing: 4) {
            RemoteImageView(imageURL: imageURL, cornerRadius: 30)
                .frame(width: 36, height: 36)
        }
    }
}

#Preview {
    SourcesView(sources: FactSource.mocks + FactSource.mocks+FactSource.mocks + FactSource.mocks+FactSource.mocks )
        .padding()
}
