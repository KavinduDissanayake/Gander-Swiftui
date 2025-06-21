//
//  AnthropicAPIResponse.swift
//  Gender
//
//  Created by KavinduDissanayake on 2025-06-20.
//

import Foundation
struct MessageContent: Decodable {
    let type: String?
    let text: String?
}

struct AnthropicAPIResponse: Decodable {
    let id: String?
    let type: String?
    let role: String?
    let content: [MessageContent]?
}

extension AnthropicAPIResponse {
    func toFactCheckResponse() throws -> FactCheckAIResponse {
        guard let textJSON = content?.first?.text?.data(using: .utf8) else {
            throw APIClientError.decodingFailed
        }
        do {
            return try JSONDecoder().decode(FactCheckAIResponse.self, from: textJSON)
        } catch {
            Logger.log(logType: .error, title: "Parsing", message: error.localizedDescription)
            throw APIClientError.decodingFailed
        }
    }
}
