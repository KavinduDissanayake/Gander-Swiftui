//
//  HomeViewModel.swift
//  Gender
//
//  Created by KavinduDissanayake on 2025-06-20.
//

// MARK: - Imports
import SwiftUI
import SwiftSoup

// MARK: - ViewModel
@MainActor
class HomeViewModel: ObservableObject {

    // MARK: - Published Properties
    @Published var currentArticle: FactCheckArticle? = nil
    @Published var isLoading: Bool = false
    @Published var isNavigateToDetails: Bool = false
    @Published var filteredArticles: [FactCheckArticle] = []
    @Published var selectedLabel: String = "All" {
        didSet {
            updateFilteredArticles()
        }
    }
    @Published var inputURL: String = ""
    @Published var isBottomSheetVisible: Bool = false
    @Published var errorMessage: String?
    @Published var selectedTab = 0

    // MARK: - Stored Articles
    @CodableAppStorage(CacheKeys.articleHisotry) var savedArticles: [FactCheckArticle] = [] {
        didSet {
            updateFilteredArticles()
        }
    }

    // MARK: - Init
    init() {
        self.updateFilteredArticles()
    }

    // MARK: - Article Filtering
    func updateFilteredArticles() {
        filteredArticles = selectedLabel == "All"
            ? savedArticles
            : savedArticles.filter { $0.status == selectedLabel }
    }

    func deleteArticle(_ article: FactCheckArticle) {
        let updatedArticles = savedArticles.filter { $0.id != article.id }
        savedArticles = updatedArticles
        if currentArticle?.id == article.id {
            currentArticle = nil
        }
        updateFilteredArticles()
    }

    // MARK: - Load & Scrape Article
    func loadArticle(from urlString: String) {
        guard let url = URL(string: urlString) else {
            handleError(APIClientError.invalidURL)
            return
        }

        isLoading = true
        errorMessage = nil

        Task {
            do {
                let article = try await scrapeArticle(from: url, urlString: urlString)
                self.currentArticle = article
                self.savedArticles.insert(article, at: 0)
                await submitFactCheck(for: article)
                updateFilteredArticles()
            } catch {
                handleError(error)
            }
        }
    }

    private func scrapeArticle(from url: URL, urlString: String) async throws -> FactCheckArticle {
        let (data, _) = try await URLSession.shared.data(from: url)
        guard let htmlString = String(data: data, encoding: .utf8) else {
            throw APIClientError.scrapingFailed
        }

        let doc: Document = try SwiftSoup.parse(htmlString)
        let headline = try doc.select("h1").first()?.text() ?? ""
        let ogImage = try doc.select("meta[property=og:image]").attr("content")

        let fallbackSelectors = [
            "ol[data-testid=live-event-stream] li p",
            "section[name=articleBody] p",
            "section[name=story] p",
            "article p",
            ".story-body p"
        ]

        var body = ""
        for selector in fallbackSelectors {
            let elements = try doc.select(selector).array()
            if !elements.isEmpty {
                body = elements.compactMap { try? $0.text() }.joined(separator: "\n\n")
                break
            }
        }

        if body.isEmpty {
            let allParagraphs = try doc.select("p").array()
            body = allParagraphs.compactMap { try? $0.text() }.joined(separator: "\n\n")
        }

        return FactCheckArticle(
            id: UUID(),
            url: urlString,
            headline: headline,
            bodyText: body,
            imageURL: ogImage.isEmpty ? nil : ogImage,
            dateSaved: Date(),
            status: FactCheckStatus.reviewing.rawValue
        )
    }

    // MARK: - Submit Fact Check
    private func submitFactCheck(for article: FactCheckArticle) async {
        guard article.url.contains("nytimes.com") else {
            handleUnverifiableArticle(article)
            return
        }

        let trimmedHeadline = String(article.headline.prefix(200))
        let trimmedBody = String(article.bodyText.prefix(800))
        let inputPrompt = Constant.factCheckPrompt(headline: trimmedHeadline, body: trimmedBody)

        do {
            let endpoint = Endpoint.generateMessage(prompt: inputPrompt)
            let outerResponse: AnthropicAPIResponse = try await APIClient.shared.request(
                to: endpoint.url,
                method: endpoint.method,
                parameters: endpoint.parameters,
                headers: endpoint.headers
            )
            let response = try outerResponse.toFactCheckResponse()
            let status = FactCheckStatus(from: response.status ?? "")
            updateArticleStatus(
                articleId: article.id,
                status: status,
                rationale: response.rationale ?? "",
                sources: response.sources ?? []
            )
        } catch {
            Logger.log(logType: .error, title: "FactCheck", message: error.localizedDescription)
            handleError(error)
            handleUnknownStatus(article, error: error)
        }

        isLoading = false
    }

    private func handleUnverifiableArticle(_ article: FactCheckArticle) {
        let fallbackSource = FactSource(
            title: article.headline,
            date: article.dateSaved.formatted(date: .abbreviated, time: .omitted),
            sourceImageURL: "",
            thumbnailImageURL: "",
            url: article.url
        )
        updateArticleStatus(
            articleId: article.id,
            status: .unverified,
            rationale: "The provided article is not from a trusted NYTimes source and cannot be verified.",
            sources: [fallbackSource]
        )
        isLoading = false
    }

    private func handleUnknownStatus(_ article: FactCheckArticle, error: Error) {
        let fallbackSource = FactSource(
            title: article.headline,
            date: article.dateSaved.formatted(date: .abbreviated, time: .omitted),
            sourceImageURL: article.imageURL ?? "",
            thumbnailImageURL: article.imageURL ?? "",
            url: article.url
        )
        updateArticleStatus(
            articleId: article.id,
            status: .unknown,
            rationale: "Error occurred during fact-checking: \(error.localizedDescription)",
            sources: [fallbackSource]
        )
    }

    // MARK: - Status Updates
    private func updateArticleStatus(articleId: UUID, status: FactCheckStatus, rationale: String, sources: [FactSource]) {
        if let index = savedArticles.firstIndex(where: { $0.id == articleId }) {
            savedArticles[index].status = status.rawValue
            savedArticles[index].rationale = rationale
            savedArticles[index].sources = sources

            let updated = savedArticles
            savedArticles = updated

            if currentArticle?.id == articleId {
                currentArticle = savedArticles[index]
            }
            updateFilteredArticles()
        }
    }

    // MARK: - Utilities
    private func handleError(_ error: Error) {
        errorMessage = error.localizedDescription
        isLoading = false
    }

    func clearError() {
        errorMessage = nil
    }

    func shareArticle(_ article: FactCheckArticle) {
        let shareText = "Fact-check result: \(article.headline) - \(article.factCheckStatus.displayName)"
        let activityVC = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            window.rootViewController?.present(activityVC, animated: true)
        }
    }

    // MARK: - Sheet Presentation
    func presentInputBottomSheet() {
        Task {
            await FactCheckInputBottomSheet(
                inputURL: Binding(get: { self.inputURL }, set: { self.inputURL = $0 }),
                viewModel: self
            ).present()
        }
    }

    func showChoseBootmSheet() {
        Task {
            await AddOptionsBottomSheet(onSelectImage: {}, onSelectLink: {
                self.presentInputBottomSheet()
            }).present()
        }
    }
}
