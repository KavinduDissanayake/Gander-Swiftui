//
//  HomeViewModel.swift
//  Gender
//
//  Created by KavinduDissanayake on 2025-06-20.
//

// MARK: - Imports
import SwiftUI
import SwiftSoup
import MijickPopups

// MARK: - ViewModel
@MainActor
class HomeViewModel: ObservableObject {

    // MARK: - Published Properties
    @Published var currentArticle: FactCheckArticle?
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
    @CodableAppStorage(CacheKeys.articleHistory) var savedArticles: [FactCheckArticle] = [] {
        didSet {
            updateFilteredArticles()
        }
    }

    // MARK: - Init
    init() {
        self.updateFilteredArticles()
    }
}

// MARK: - Article Filtering & Storage
extension HomeViewModel {
    func updateFilteredArticles() {
        filteredArticles = selectedLabel == "All"
            ? savedArticles.sorted { $0.dateSaved > $1.dateSaved }
            : savedArticles.filter { $0.status == selectedLabel }.sorted { $0.dateSaved > $1.dateSaved }
    }

    func refreshArticles() {
        self.updateFilteredArticles()
    }

    func deleteArticle(_ article: FactCheckArticle) {
        let updatedArticles = savedArticles.filter { $0.id != article.id }
        savedArticles = updatedArticles
        if currentArticle?.id == article.id {
            currentArticle = nil
        }
        updateFilteredArticles()
    }
}

// MARK: - Article Loading & Scraping
extension HomeViewModel {
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

                if let existingIndex = savedArticles.firstIndex(where: { $0.url == urlString }) {
                    var updated = updateExistingArticle(existing: savedArticles[existingIndex], with: article)
                    updated.status = FactCheckStatus.reviewing.rawValue
                    savedArticles[existingIndex] = updated
                    self.currentArticle = updated
                } else {
                    savedArticles.insert(article, at: 0)
                    self.currentArticle = article
                }
                await submitFactCheck(for: article)
                updateFilteredArticles()
            } catch {
                handleError(error)
            }
        }
    }

    private func updateExistingArticle(existing: FactCheckArticle, with newArticle: FactCheckArticle) -> FactCheckArticle {
        var updated = existing
        updated.headline = newArticle.headline
        updated.bodyText = newArticle.bodyText
        updated.imageURL = newArticle.imageURL
        updated.dateLastRefreshed = Date()
        return updated
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
}

// MARK: - Fact Check Submission
extension HomeViewModel {

    public func resumePendingFactChecks() {
        Logger.log(logType: .info, title: "FactCheck", message: "Resuming pending fact checks if any")

        Task {
            for article in savedArticles where article.status == FactCheckStatus.reviewing.rawValue {
                guard !isLoading else { break }
                currentArticle = article
                isLoading = true
                await submitFactCheck(for: article)
            }
        }
    }

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
            Logger.log(logType: .success, title: "FactCheck", message: "Fact check completed successfully for article: \(article.url)")
        } catch {
            Logger.log(logType: .error, title: "FactCheck", message: error.localizedDescription)
            handleError(error)
            handleUnknownStatus(article, error: error)
        }
        clearInputFieldAndAlerts()
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
        let message = error.localizedDescription

        updateArticleStatus(
            articleId: article.id,
            status: .unknown,
            rationale: "Error occurred during fact-checking: \(message)",
            sources: [fallbackSource]
        )
    }
}

// MARK: - Article Status Updates
extension HomeViewModel {
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
}

// MARK: - Error Handling
extension HomeViewModel {
    private func handleError(_ error: Error) {
        let message = error.localizedDescription
        errorMessage = message
        AlertManager.showTopBanner("Error", message, type: .error)
        isLoading = false
    }

    func clearError() {
        errorMessage = nil
    }
}

// MARK: - UI Helpers
extension HomeViewModel {
    private func clearInputFieldAndAlerts() {
        inputURL = ""
        AlertManager.dismissAllAlerts()
    }

    func shareArticle(_ article: FactCheckArticle) {
        let shareText = "Fact-check result: \(article.headline) - \(article.factCheckStatus.displayName)"
        let activityVC = UIActivityViewController(activityItems: [shareText], applicationActivities: nil)
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            window.rootViewController?.present(activityVC, animated: true)
        }
    }

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
