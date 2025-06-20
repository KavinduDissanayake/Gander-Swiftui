//
//  GenderTests.swift
//  GenderTests
//
//  Created by KavinduDissanayake on 2025-06-20.
//
import Foundation
import Testing
@testable import Gender

struct GenderTests {

    @Test
    func testLoadArticleFailureWithInvalidURL() async throws {
        let viewModel = await HomeViewModel()
        let invalidURL = "not a real url"

        await viewModel.loadArticle(from: invalidURL)

        #expect(viewModel.currentArticle == nil)
        await #expect(viewModel.errorMessage != nil)
        await #expect(viewModel.isLoading == false)
    }

    @Test
    func testDeleteArticleRemovesCorrectItem() async throws {
        let viewModel = await HomeViewModel()
        let article = FactCheckArticle.mock
        viewModel.savedArticles = [article]
        viewModel.currentArticle = article

        viewModel.deleteArticle(article)

        #expect(viewModel.savedArticles.isEmpty)
        #expect(viewModel.currentArticle == nil)
    }
}
