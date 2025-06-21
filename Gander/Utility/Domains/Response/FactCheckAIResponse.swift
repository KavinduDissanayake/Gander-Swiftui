//
//  FactCheckAIResponse.swift
//  Gender
//
//  Created by KavinduDissanayake on 2025-06-20.
//
import Foundation

struct FactCheckAIResponse: Codable {
    let status: String?
    let rationale: String?
    let sources: [FactSource]?
}

struct FactSource: Codable {
    let title: String?
    let date: String?
    let sourceImageURL: String?
    let thumbnailImageURL: String?
    let url: String?
}

extension FactSource {
    static var mock: FactSource {
        FactSource(
            title: "Sample Source Title",
            date: "2025-06-20",
            sourceImageURL: "https://via.placeholder.com/36",
            thumbnailImageURL: nil,
            url: "https://example.com/mock"
        )
    }

    static var mocks: [FactSource] {
        return [
            .mock,
            FactSource(title: "Another Source", date: "2025-06-19", sourceImageURL: "https://via.placeholder.com/36", thumbnailImageURL: nil, url: "https://example.com/2"),
            FactSource(title: "Source Three", date: "2025-06-18", sourceImageURL: "https://via.placeholder.com/36", thumbnailImageURL: nil, url: "https://example.com/3")
        ]
    }
}
