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
        ZStack(alignment: .bottom){
            
            VStack(spacing: 20) {
                // Results Section
                if viewModel.savedArticles.isEmpty {
                    EmptyStatePlaceholder()
                } else {
                    Text("Recent Fact Checks")
                        .font(.headline)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal)
                    
                    FactCheckResultListView(articles: $viewModel.savedArticles, viewModel: viewModel)
                    
                    Spacer()
                }
            }
            
            Button(action: {
                viewModel.isBottomSheetVisible = true
            }) {
                Image(systemName: "eye")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.black)
                    .padding(20)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
            }
            .frame(width: 60, height: 60)
            .padding()
            .vAlign(.bottom)
            
        }
        .sheet(isPresented: $viewModel.isBottomSheetVisible) {
            FactCheckInputBottomSheet(inputURL: $viewModel.inputURL, viewModel: viewModel)
        }
        .applyHomeNavigationBarTool(viewModel: viewModel)
    }
}


#Preview {
    HomeView()
}

// MARK: - Empty State Placeholder
struct EmptyStatePlaceholder: View {
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: "doc.text.magnifyingglass")
                .resizable()
                .scaledToFit()
                .frame(width: 80, height: 80)
                .foregroundColor(.gray)
            Text("No articles fact-checked yet.")
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding()
        .vAlign(.center)

    }
}
