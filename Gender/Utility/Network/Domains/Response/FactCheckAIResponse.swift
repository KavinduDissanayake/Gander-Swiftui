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
