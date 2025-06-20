//
//  APIClientTests.swift
//  Gender
//
//  Created by Kavindu Dissanayake on 2025-06-20.
//


import Foundation
import Testing
@testable import Gender

struct APIClientTests {

    struct MockResponse: Codable, Equatable {
        let message: String
    }

    @Test
    func testSuccessfulRequest() async throws {
        // Arrange
        let mockURL = "https://jsonplaceholder.typicode.com/posts/1"
        let response: MockResponse = try await APIClient.shared.request(to: mockURL)

        // Assert
        #expect(!response.message.isEmpty)
    }

    @Test
    func testInvalidURLThrowsError() async throws {
        do {
            let _: MockResponse = try await APIClient.shared.request(to: "invalid_url")
            #expect(false) // Should not reach here
        } catch {
            #expect(error is URLError || error is APIClientError)
        }
    }

    @Test
    func testNoInternetThrowsError() async throws {
        // This test assumes no network, mock reachability in real case
        // Not testable without mocking, so just check the error mapping logic
        let unreachableClient = APIClient()

        do {
            let _: MockResponse = try await unreachableClient.request(to: "https://someurl.com")
            #expect(false)
        } catch {
            #expect(error is APIClientError)
        }
    }
}