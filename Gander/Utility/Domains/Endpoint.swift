//
//  Endpoint.swift
//  Gender
//
//  Created by KavinduDissanayake on 2025-06-20.
//

import Alamofire

enum Endpoint {
    case generateMessage(prompt: String)

    var url: String {
        switch self {
        case .generateMessage:
            return "https://api.anthropic.com/v1/messages"
        }
    }

    var method: HTTPMethod {
        return .post
    }

    var headers: HTTPHeaders {
        return [
            "x-api-key": Constant.anthropicAPIKey,
            "Content-Type": "application/json",
            "anthropic-version": "2023-06-01"
        ]
    }

    var parameters: Parameters {
        switch self {
        case .generateMessage(let prompt):
            return [
                "model": "claude-3-5-sonnet-20241022",
                "max_tokens": 1000,
                "messages": [
                    ["role": "user", "content": prompt]
                ]
            ]
        }
    }
}
