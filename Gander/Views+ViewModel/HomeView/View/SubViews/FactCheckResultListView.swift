//
//  FactCheckResultListView.swift
//  Gender
//
//  Created by KavinduDissanayake on 2025-06-20.
//

import SwiftUI
import WaterfallGrid
// MARK: - Main App with Tab Navigation

struct FactCheckResultListView: View {
    @Binding var articles: [FactCheckArticle]
    @ObservedObject var viewModel: HomeViewModel

    var body: some View {
        ScrollView(showsIndicators: true) {
            WaterfallGrid(viewModel.filteredArticles, id: \.id) { article in
                FactCardView(
                    article: article,
                    onShare: {
                        viewModel.shareArticle(article)
                    },
                    onRefresh: {
                        viewModel.loadArticle(from: article.url)
                    },
                    onDelete: {
                        viewModel.deleteArticle(article)
                    },
                    onTap: {
                        viewModel.currentArticle = article
                        viewModel.isNavigateToDetails.toggle()
                    }
                )

            }
            .gridStyle(
                columnsInPortrait: 2,
                columnsInLandscape: 4,
                spacing: 16,
                animation: .default
            )
            .padding()
        }
        .refreshable {
            viewModel.refreshArticles()
        }
        .navigate(to: ArticleDetailView(article: viewModel.currentArticle), when: $viewModel.isNavigateToDetails)
    }
}
