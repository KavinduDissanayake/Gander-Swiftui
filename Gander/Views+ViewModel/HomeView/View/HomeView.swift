//
//  HomeView.swift
//  Gender
//
//  Created by KavinduDissanayake on 2025-06-20.
//

import SwiftUI

// MARK: - Enhanced Main View

struct HomeView: View {
    @ObservedObject var viewModel: HomeViewModel = .init()

    var body: some View {
        ZStack(alignment: .bottom) {

            VStack(spacing: 20) {
                // Results Section
                if viewModel.filteredArticles.isEmpty {
                    EmptyStatePlaceholder()
                } else {
                    Text("Recent Fact Checks")
                        .fontSemiBold(17)
                        .hLeading()
                        .padding(.horizontal)

                    FactCheckResultListView(articles: $viewModel.savedArticles, viewModel: viewModel)
                }
            }

            Button(action: {
                viewModel.showChoseBootmSheet()
            }) {
                Image(.icFloat)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 60, height: 60)
                    .padding()
            }
            .vAlign(.bottom)

        }
        .onAppear {
            viewModel.resumePendingFactChecks()
        }
        .applyHomeNavigationBarTool(viewModel: viewModel)
    }
}

#Preview {
    HomeView()
}
