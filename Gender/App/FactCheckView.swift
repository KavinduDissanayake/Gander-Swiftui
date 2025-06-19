//
//  FactCheckView.swift
//  Gender
//
//  Created by KavinduDissanayake on 2025-06-20.
//

import SwiftUI
import SwiftSoup

// MARK: - Main App with Tab Navigation


struct FactCheckResultListView: View {
    @Binding var articles: [FactCheckArticle]
    @ObservedObject var viewModel: HomeViewModel

    var filteredArticles: [FactCheckArticle] {
        if viewModel.selectedLabel == "All" {
            return articles
        } else {
            return articles.filter { $0.status == viewModel.selectedLabel }
        }
    }

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 16) {
                ForEach(filteredArticles.prefix(10), id: \.id) { article in
                    NavigationLink(destination: FactCheckCurrentArticleView(article: article)) {
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
                            }
                        )
                    }
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding()
        }
    }
}

struct FactCheckHistoryView: View {
    let articles: [FactCheckArticle]
    let viewModel: HomeViewModel

    var body: some View {
        NavigationView {
            List {
                ForEach(articles) { article in
                    NavigationLink(destination: FactCheckCurrentArticleView(article: article)) {
                        FactCheckHistoryRowView(article: article)
                    }
                }
                .onDelete(perform: deleteArticles)
            }
            .navigationTitle("History")
            .toolbar {
                EditButton()
            }
        }
    }
    
    private func deleteArticles(offsets: IndexSet) {
        for index in offsets {
            viewModel.deleteArticle(articles[index])
        }
    }
}

struct FactCheckHistoryRowView: View {
    let article: FactCheckArticle
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            // Thumbnail
            if let imageURL = article.imageURL, let url = URL(string: imageURL) {
                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 60, height: 60)
                            .cornerRadius(8)
                    case .success(let image):
                        image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: 60, height: 60)
                            .clipped()
                            .cornerRadius(8)
                    case .failure:
                        Rectangle()
                            .fill(Color.gray.opacity(0.3))
                            .frame(width: 60, height: 60)
                            .cornerRadius(8)
                            .overlay(
                                Image(systemName: "photo")
                                    .foregroundColor(.gray)
                            )
                    @unknown default:
                        EmptyView()
                    }
                }
            }

            // Content
            VStack(alignment: .leading, spacing: 4) {
                Text(article.headline)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .lineLimit(2)

                Text(article.dateSaved.formatted(date: .abbreviated, time: .shortened))
                    .font(.caption)
                    .foregroundColor(.secondary)
                
                // Status badge
                HStack {
                    Image(systemName: article.factCheckStatus.iconName)
                        .font(.caption)
                    Text(article.factCheckStatus.displayName)
                        .font(.caption)
                        .fontWeight(.medium)
                }
                .foregroundColor(article.factCheckStatus.color)
            }
            
            Spacer()
        }
        .padding(.vertical, 4)
    }
}

struct FactCheckSettingsView: View {
    var body: some View {
        NavigationView {
            List {
                Section("About") {
                    HStack {
                        Image(systemName: "checkmark.shield")
                        VStack(alignment: .leading) {
                            Text("Fact Checker App")
                                .fontWeight(.medium)
                            Text("Version 1.0")
                                .font(.caption)
                                .foregroundColor(.secondary)
                        }
                    }
                }
                
                Section("Trusted Sources") {
                    HStack {
                        Image(systemName: "newspaper")
                        Text("The New York Times")
                    }
                    
                    Text("Currently, this app only fact-checks articles from The New York Times for reliability.")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
            }
            .navigationTitle("Settings")
        }
    }
}

// MARK: - Preview

#Preview("Main App") {
    HomeView()
}



struct FactCheckCurrentArticleView: View {
    let article: FactCheckArticle

    var body: some View {
        ScrollView {
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
                
//                if let sources = article.sources {
//                    SourcesView(sources: sources)
//                }
                // Share Button
                Button(action: shareResults) {
                    HStack {
                        Image(systemName: "square.and.arrow.up")
                        Text("Share Results")
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                }
            }
            .padding()
        }
        .navigationBarTitleDisplayMode(.inline)
    }
    
     func shareResults() {
        let shareText = "Fact-check result: \(article.headline) - \(article.factCheckStatus.displayName)"
        let activityVC = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            window.rootViewController?.present(activityVC, animated: true)
        }
    }
}


#Preview("FactCheckCurrentArticleView") {
    NavigationView {
        FactCheckCurrentArticleView(article: FactCheckArticle.mock)
    }
}


// MARK: - Private Components

 struct FactCheckImageHeaderView: View {
    let imageUrl: String?
    let headline: String
    let date: Date
    let status: FactCheckStatus

    var body: some View {
        VStack(spacing: 0) {
            RemoteImageView(imageURL: imageUrl)
                .frame(height: 200)
                .clipped()

            VStack(alignment: .leading, spacing: 8) {
                Text(headline)
                    .font(.headline)
                    .lineLimit(3)
                    .multilineTextAlignment(.leading)

                Text(date.formatted(date: .abbreviated, time: .shortened))
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)

            HStack {
                Text(status.displayName)
                    .font(.caption)
                    .bold()

                Spacer()

                Image(systemName: status.iconName)
            }
            .padding(.horizontal, 12)
            .padding(.vertical, 8)
            .background(status.color)
        }
        .cornerRadius(12)
    }
}

 struct FactCheckStatusBadgeView: View {
    let status: FactCheckStatus
    var body: some View {
        HStack {
            Image(systemName: status.iconName)
            Text(status.displayName)
                .fontWeight(.semibold)
            Spacer()
        }
        .foregroundColor(.white)
        .padding()
        .background(status.color)
        .cornerRadius(12)
    }
}

 struct FactCheckAnalysisView: View {
    let rationale: String
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Fact-Check Analysis")
                .font(.headline)
            Text(rationale)
                .font(.body)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
        }
    }
}

struct FactCheckArticlePreviewView: View {
    let bodyText: String

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Article Content")
                .font(.headline)

            Text(String(bodyText.prefix(500)) + (bodyText.count > 500 ? "..." : ""))
                .font(.body)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
    }
}
//
//struct SourcesView: View {
//    let sources: [FactSource]
//    private let maxDisplay = 3
//
//    var body: some View {
//        VStack(alignment: .leading, spacing: 12) {
//            Text("Sources")
//                .font(.headline)
//
//            ForEach(sources.prefix(maxDisplay), id: \.url) { source in
//                SourceRowView(source: source)
//            }
//
//            if sources.count > maxDisplay {
//                HStack(spacing: 8) {
//                    Text("Other Sources")
//                        .font(.subheadline)
//                        .fontWeight(.semibold)
//                        .foregroundColor(.white)
//
//                    let otherSources = sources.suffix(from: maxDisplay).prefix(3)
//                    ForEach(Array(otherSources.enumerated()), id: \.offset) { index, source in
//                        VStack {
//                            RemoteImageView(imageURL: source.sourceImageURL ?? "", cornerRadius: 999)
//                                .frame(width: 36, height: 36)
//                            Text("\(index + 1)")
//                                .font(.caption2)
//                                .foregroundColor(.white)
//                        }
//                    }
//
//                    if sources.count > maxDisplay + 3 {
//                        Image(systemName: "plus.circle.fill")
//                            .foregroundColor(.white)
//                    }
//                }
//                .padding(.top, 8)
//            }
//        }
//    }
//}
////
//struct SourceRowView: View {
//    let source: FactSource
//
//    var body: some View {
//        HStack(alignment: .top, spacing: 12) {
//            RemoteImageView(imageURL: source.sourceImageURL ?? "", cornerRadius: 30)
//                .frame(width: 32, height: 32)
//
//            VStack(alignment: .leading, spacing: 4) {
//                Text(source.title ?? "Unknown Title")
//                    .font(.subheadline)
//                    .fontWeight(.semibold)
//
//                Text(source.date ?? "")
//                    .font(.caption)
//                    .foregroundColor(.gray)
//            }
//
//            Spacer()
//
//            RemoteImageView(imageURL: source.thumbnailImageURL ?? "", cornerRadius: 4)
//                .frame(width: 32, height: 32)
//        }
//    }
//}


//# MARK: - Bottom Sheet Input View

struct FactCheckInputBottomSheet: View {
    @Binding var inputURL: String
    @ObservedObject var viewModel: HomeViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Enter NYTimes Article URL")
                .font(.headline)
                .padding(.horizontal)

            TextField("https://www.nytimes.com/...", text: $inputURL)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .autocorrectionDisabled()
                .padding(.horizontal)

            Button("Check Facts") {
                viewModel.loadArticle(from: inputURL)
            }
            .frame(maxWidth: .infinity)
            .padding()
            .background(inputURL.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? Color.gray : Color.blue)
            .foregroundColor(.white)
            .cornerRadius(8)
            .padding(.horizontal)
            .disabled(inputURL.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || viewModel.isLoading)

            if let errorMessage = viewModel.errorMessage {
                HStack {
                    Image(systemName: "exclamationmark.triangle.fill")
                        .foregroundColor(.orange)
                    Text(errorMessage)
                        .font(.caption)
                        .foregroundColor(.red)
                    Spacer()
                    Button("Dismiss") {
                        viewModel.clearError()
                    }
                    .font(.caption)
                    .foregroundColor(.blue)
                }
                .padding()
                .background(Color.red.opacity(0.1))
                .cornerRadius(8)
                .padding(.horizontal)
            }

            if viewModel.isLoading {
                VStack {
                    ProgressView()
                    Text("Analyzing article...")
                        .font(.caption)
                        .foregroundColor(.secondary)
                }
                .padding()
            }
        }
        .padding(.bottom)
        .background(Color(.systemBackground))
        .cornerRadius(16)
        .shadow(radius: 8)
    }
}


// MARK: - Custom Toolbar Modifier

struct HomeNavigationBarToolModifier: ViewModifier {
    @ObservedObject var viewModel: HomeViewModel

    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Ganders")
                        .font(.headline)
                }

                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Menu {
                        Picker("Filter by Status", selection: $viewModel.selectedLabel) {
                            Text("All").tag("All")
                            Text("Verified").tag(FactCheckStatus.verified.rawValue)
                            Text("Unverified").tag(FactCheckStatus.unverified.rawValue)
                            Text("Misinterpretation").tag(FactCheckStatus.misinterpretation.rawValue)
                            Text("Reviewing").tag(FactCheckStatus.reviewing.rawValue)
                            Text("Unknown").tag(FactCheckStatus.unknown.rawValue)
                        }
                    } label: {
                        Image(systemName: "ellipsis")
                    }

                    Button(action: {
                        // Handle notification action
                    }) {
                        Image(systemName: "bell")
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
    }
}

extension View {
    func applyHomeNavigationBarTool(viewModel: HomeViewModel) -> some View {
        self.modifier(HomeNavigationBarToolModifier(viewModel: viewModel))
    }
}
