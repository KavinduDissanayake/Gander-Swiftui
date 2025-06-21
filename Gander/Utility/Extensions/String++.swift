//
//  String++.swift
//  Gander
//
//  Created by KavinduDissanayake on 2025-06-22.
//
import Foundation

extension Optional where Wrapped == String {
    var orUnknownTitle: String {
        guard let text = self?.trimmingCharacters(in: .whitespacesAndNewlines),
              !text.isEmpty else {
            return "Unknown Title"
        }
        // Collapse multiple spaces/newlines into single space
        let cleaned = text.replacingOccurrences(of: "\\s+", with: " ", options: .regularExpression)
        return cleaned
    }
}
