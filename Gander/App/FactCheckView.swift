// MARK: - Add Option Row

//
//  FactCheckView.swift
//  Gender
//
//  Created by KavinduDissanayake on 2025-06-20.
//


import SwiftUI

struct SourceRowView: View {
    let source: FactSource

    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            RemoteImageView(imageURL: source.sourceImageURL ?? "", cornerRadius: 30)
                .frame(width: 32, height: 32)

            VStack(alignment: .leading, spacing: 4) {
                Text(source.title ?? "Unknown Title")
                    .font(.subheadline)
                    .fontWeight(.semibold)

                Text(source.date ?? "")
                    .font(.caption)
                    .foregroundColor(.gray)
            }

            Spacer()

            RemoteImageView(imageURL: source.thumbnailImageURL ?? "", cornerRadius: 4)
                .frame(width: 32, height: 32)
        }
    }
}



// MARK: - Mock Data for Previews

#if DEBUG
extension FactCheckArticle {
    static var mockMultiple: [FactCheckArticle] {
        [
            FactCheckArticle.mock,
            FactCheckArticle.mock,
            FactCheckArticle.mock
        ]
    }
}

extension HomeViewModel {
    static var mock: HomeViewModel {
        let vm = HomeViewModel()
        vm.filteredArticles = FactCheckArticle.mockMultiple
        return vm
    }
}

struct AddOptionRow_Previews: PreviewProvider {
    static var previews: some View {
        AddOptionRow(icon: "link", title: "Link") { }
            .padding()
            .previewLayout(.sizeThatFits)
            .background(Color(.systemBackground))
    }
}
#endif

// MARK: - Preview for Full Article Detail

#if DEBUG
struct FactCheckArticleDetail_Previews: PreviewProvider {
    static var previews: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                FactCheckImageHeaderView(
                    imageUrl: FactCheckArticle.mock.imageURL,
                    headline: FactCheckArticle.mock.headline,
                    date: FactCheckArticle.mock.dateSaved,
                    status: FactCheckArticle.mock.factCheckStatus
                )
                if let rationale = FactCheckArticle.mock.rationale {
                    FactCheckAnalysisView(rationale: rationale)
                }
                FactCheckArticlePreviewView(bodyText: FactCheckArticle.mock.bodyText)
                if let sources = FactCheckArticle.mock.sources {
                    SourcesView(sources: sources)
                }
            }
            .padding()
        }
        .previewDisplayName("FactCheck Article Details")
    }
}

struct FactCheckInputBottomSheet_Previews: PreviewProvider {
    static var previews: some View {
        FactCheckInputBottomSheet(inputURL: .constant("https://www.nytimes.com/2025/06/18/sample-article.html"), viewModel: .mock)
    }
}
#endif
