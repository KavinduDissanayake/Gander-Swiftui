//
//  FactCheckArticle.swift
//  Gender
//
//  Created by KavinduDissanayake on 2025-06-20.
//

import SwiftUI

struct FactCheckArticle: Identifiable, Codable {
    let id: UUID
    let url: String
    let headline: String
    let bodyText: String
    let imageURL: String?
    let dateSaved: Date
    var status: String?
    var rationale: String?
    var sources: [FactSource]?
    
    var factCheckStatus: FactCheckStatus {
        guard let status = status else { return .unknown }
        return FactCheckStatus(from: status)
    }
}

enum FactCheckStatus: String, CaseIterable {
    case verified = "VERIFIED"
    case unverified = "UNVERIFIED"
    case misinterpretation = "MISINTERPRETATION"
    case unknown = "UNKNOWN"
    case reviewing = "REVIEWING"

    init(from result: String) {
        let upper = result.uppercased()
        if upper.contains(Self.unverified.rawValue) {
            self = .unverified
        } else if upper.contains(Self.misinterpretation.rawValue) {
            self = .misinterpretation
        } else if upper.contains(Self.verified.rawValue) {
            self = .verified
        } else if upper.contains(Self.reviewing.rawValue) {
            self = .reviewing
        } else {
            self = .unknown
        }
    }

    var iconName: String {
        switch self {
        case .verified: return "checkmark.circle.fill"
        case .unverified: return "xmark.circle.fill"
        case .misinterpretation: return "exclamationmark.triangle.fill"
        case .reviewing: return "clock.fill"
        case .unknown: return "questionmark.circle.fill"
        }
    }

    var color: Color {
        switch self {
        case .verified: return .emeraldGreen
        case .unverified: return .carmineRed
        case .misinterpretation: return .sunsetOrange
        case .reviewing: return .blue
        case .unknown: return .gray
        }
    }
    
    var displayName: String {
        switch self {
        case .verified: return "Verified"
        case .unverified: return "Unverified"
        case .misinterpretation: return "Misinterpretation"
        case .reviewing: return "Reviewing"
        case .unknown: return "Unknown"
        }
    }
}


extension FactCheckArticle {
    static var mock: FactCheckArticle {
        FactCheckArticle(
            id: UUID(),
            url: "https://www.nytimes.com/2025/06/18/sample-article.html",
            headline: "Sample Headline for Testing",
            bodyText: "This is the body of the article used for preview and testing purposes. It contains multiple sentences to show how the content would be displayed in the app.",
            imageURL: "https://static01.nyt.com/images/2021/12/01/arts/01artsbriefs1/01artsbriefs1-mediumSquareAt3X.jpg",
            dateSaved: Date(),
            status: "UNVERIFIED",
            rationale: "This article has been verified through multiple credible sources and fact-checking databases.",
            sources: [
                FactSource(
                    title: "Sample Headline for Testing",
                    date: "WEDNESDAY, 19 JUNE 2025",
                    sourceImageURL: "https://upload.wikimedia.org/wikipedia/commons/4/40/New_York_Times_logo_variation.jpg",
                    thumbnailImageURL: "https://static01.nyt.com/images/2021/12/01/arts/01artsbriefs1/01artsbriefs1-mediumSquareAt3X.jpg",
                    url: "https://www.nytimes.com/2025/06/18/sample-article.html"
                ),
                FactSource(
                    title: "WSJ confirms the study",
                    date: "TUESDAY, 18 JUNE 2025",
                    sourceImageURL: "https://upload.wikimedia.org/wikipedia/commons/0/0d/The_Wall_Street_Journal_Logo.svg",
                    thumbnailImageURL: "https://images.wsj.net/im-123456?width=700&height=450",
                    url: "https://www.wsj.com/articles/new-color-study"
                ),
                FactSource(
                    title: "Scientific American review",
                    date: "MONDAY, 17 JUNE 2025",
                    sourceImageURL: "https://upload.wikimedia.org/wikipedia/commons/f/fc/Scientific_American_logo.png",
                    thumbnailImageURL: "https://static.scientificamerican.com/sciam/cache/file/1E71BB19-7601-4DF5-9BE70DA8C16876CE.jpg",
                    url: "https://www.scientificamerican.com/article/new-color-discovery/"
                ),
                FactSource(
                    title: "BBC discusses findings",
                    date: "SUNDAY, 16 JUNE 2025",
                    sourceImageURL: "https://upload.wikimedia.org/wikipedia/commons/b/bc/BBC_News_2022.svg",
                    thumbnailImageURL: "https://ichef.bbci.co.uk/news/976/cpsprodpb/1836/production/_123456789_news.jpg",
                    url: "https://www.bbc.com/news/science-environment-654321"
                ),
                FactSource(
                    title: "Nature publishes report",
                    date: "SATURDAY, 15 JUNE 2025",
                    sourceImageURL: "https://upload.wikimedia.org/wikipedia/commons/d/dc/Nature_logo.svg",
                    thumbnailImageURL: "https://media.springernature.com/full/springer-static/image/art%3A10.1038%2Fnews050523-6/MediaObjects/41586_2005_Article_BFnews050523-6_Figa_HTML.jpg",
                    url: "https://www.nature.com/articles/color-discovery-2025"
                )
            ]
        )
    }
}
