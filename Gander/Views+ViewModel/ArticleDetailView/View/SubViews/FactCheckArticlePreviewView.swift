//
//  FactCheckArticlePreviewView.swift
//  Gender
//
//  Created by KavinduDissanayake on 2025-06-20.
//

import SwiftUI

// MARK: - Article Content View
struct FactCheckArticlePreviewView: View {
    let bodyText: String

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Detailed Summary")
                .font(.headline)

            ExpandableText(bodyText, lineLimit: 5)
                .fontRegular(14)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
    }
}

// MARK: - Preview
#Preview("ArticleDetailPreview") {
    FactCheckArticlePreviewView(bodyText: """
    This is a sample article body text used for preview purposes. It contains multiple lines of information that help visualize how the content will look in the app. The content should be truncated after 500 characters to simulate the real display logic. Additional text can be added here to ensure we test the ellipsis behavior effectively.
    """)
}
