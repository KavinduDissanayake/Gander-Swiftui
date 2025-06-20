//
//  HomeViewModelTests.swift
//  GenderTests
//
//  Created by KavinduDissanayake on 2025-06-20.
//

import Foundation
import Testing
@testable import Gender

struct HomeViewModelTests {

    @Test
    func testLoadArticleFailureWithInvalidURL() async throws {
        let viewModel = await HomeViewModel()
        let invalidURL = "not a real url"

        await viewModel.loadArticle(from: invalidURL)

        await #expect(viewModel.currentArticle == nil)
        await #expect(viewModel.errorMessage != nil)
        await #expect(viewModel.isLoading == false)
    }

   
    @Test
    func testShareArticle() async throws {
        let viewModel = await HomeViewModel()
        let article = FactCheckArticle.mock
        await viewModel.shareArticle(article)
        #expect(true) // No crash means pass
    }
}
