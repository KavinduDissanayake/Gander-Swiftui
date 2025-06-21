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

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Sources")
                .fontSemiBold(17)

            ForEach(sources.prefix(maxDisplay), id: \.url) { source in
                SourceRowView(source: source)
            }

            if sources.count > maxDisplay {
                HStack(spacing: 8) {
                    Text("Other Sources")
                        .fontMedium(15)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)

                    let otherSources = sources.suffix(from: maxDisplay).prefix(3)
                    ForEach(Array(otherSources.enumerated()), id: \.offset) { index, source in
                        VStack {
                            RemoteImageView(imageURL: source.sourceImageURL ?? "", cornerRadius: 999)
                                .frame(width: 36, height: 36)
                            Text("\(index + 1)")
                                .fontRegular(11)
                                .foregroundColor(.white)
                        }
                    }

                    if sources.count > maxDisplay + 3 {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.white)
                    }
                }
                .padding(.top, 8)
            }
        }
    }
}

#Preview {
    SourcesView(sources: FactSource.mocks + FactSource.mocks)
}
