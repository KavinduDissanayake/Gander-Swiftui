//
//  ArticleDetailView.swift
//  Gender
//
//  Created by KavinduDissanayake on 2025-06-20.
//

import SwiftUI
import SwiftSoup

struct ArticleDetailView: View {
    @Environment(\.dismiss) private var dismiss
    let article: FactCheckArticle?

    var body: some View {
        if let article = article {
          ScrollView(showsIndicators: false) {
                VStack(alignment: .leading, spacing: 20) {
                    FactCheckImageHeaderView(
                        imageUrl: article.imageURL,
                        headline: article.headline,
                        date: article.dateSaved,
                        status: article.factCheckStatus
                    )

                    if let rationale = article.rationale {
                        FactCheckAnalysisView(rationale: rationale)
                    }

                    FactCheckArticlePreviewView(bodyText: article.bodyText)

                    if let sources = article.sources {
                        SourcesView(sources: sources)
                    }

                    Spacer()

                    Button(action: {
                        shareResults(article)
                    }) {
                        HStack {
                            Image(systemName: "square.and.arrow.up")
                            Text("Share Results")
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.neutralBackground)
                        .foregroundColor(.white)
                        .cornerRadius(12)
                    }
                }
            }
            .padding(.all, 20)
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        dismiss()
                    }) {
                        Label("Back", systemImage: "chevron.left")
                            .fontSemiBold(17)
                    }
                }
            }
            .tint(.tint)
            .navigationBarTitleDisplayMode(.inline)
        } else {
            EmptyView()
        }
    }

    func shareResults(_ article: FactCheckArticle) {
        let shareText = "Fact-check result: \(article.headline) - \(article.factCheckStatus.displayName)"
        let activityVC = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)

        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            window.rootViewController?.present(activityVC, animated: true)
        }
    }
}

#Preview("ArticleDetailView") {
    NavigationStack {
        ArticleDetailView(article: FactCheckArticle.mock)
    }
}
