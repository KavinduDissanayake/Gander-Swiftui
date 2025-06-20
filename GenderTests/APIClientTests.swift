import Foundation
import Testing
@testable import Gander

struct APIClientTests {

    struct MockResponse: Codable, Equatable {
        let userId: Int
        let id: Int
        let title: String
        let body: String
    }

    @Test
    func testSuccessfulRequest() async throws {
        // Arrange
        let mockURL = "https://jsonplaceholder.typicode.com/posts/1"

        // Act
        let response: MockResponse = try await APIClient.shared.request(to: mockURL)

        // Assert
        #expect(response.id == 1)
        #expect(!response.title.isEmpty)
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
    func testRequestWithTimeout() async throws {
        do {
            let _: MockResponse = try await APIClient.shared.request(
                to: "https://jsonplaceholder.typicode.com/posts/1",
                timeoutInterval: 0.0001
            )
            #expect(false)
        } catch {
            #expect(error is APIClientError)
        }
    }

    @Test
    func testDecodeFailureThrowsError() async throws {
        struct WrongModel: Codable {
            let nonExistentField: String
        }

        do {
            let _: WrongModel = try await APIClient.shared.request(to: "https://jsonplaceholder.typicode.com/posts/1")
            #expect(false)
        } catch {
            #expect(error is APIClientError)
        }
    }
}
