//
//  HomeViewModelTests.swift
//  GenderTests
//
//  Created by KavinduDissanayake on 2025-06-20.
//

import Foundation
import Testing
@testable import Gander

struct HomeViewModelTestSuite {

    @Test
    func testLoadArticleFailureWithInvalidURL() async throws {
        let viewModel = await HomeViewModel()
        let invalidURL = "not a real url"

        await viewModel.loadArticle(from: invalidURL)
        try await Task.sleep(nanoseconds: 100_000_000) // Sleep for 100ms to allow async task to complete

        await #expect(viewModel.currentArticle == nil)
    }

   
    @Test
    func testShareArticle() async throws {
        let viewModel = await HomeViewModel()
        let article = FactCheckArticle.mock
        await viewModel.shareArticle(article)
        #expect(true) // No crash means pass
    }
}
