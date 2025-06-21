//
//  ErrorResponse.swift
//  Gander
//
//  Created by KavinduDissanayake on 2025-06-21.
//

// MARK: - Error Response Structure
struct ErrorResponse: Codable, Error {
    let code: Int?
    let message: String?

    enum RootKeys: String, CodingKey {
        case error
    }

    enum ErrorKeys: String, CodingKey {
        case code
        case message
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: RootKeys.self)
        let errorContainer = try container.nestedContainer(keyedBy: ErrorKeys.self, forKey: .error)
        self.code = try? errorContainer.decodeIfPresent(Int.self, forKey: .code)
        self.message = try? errorContainer.decodeIfPresent(String.self, forKey: .message)
    }
}
