//
//  Optional++.swift
//  Gender
//
//  Created by KavinduDissanayake on 2025-06-20.
//

import Foundation

extension Optional: RawRepresentable where Wrapped: Codable {
    public var rawValue: String {
        guard let wrapped = self else { return "null" }
        guard let data = try? JSONEncoder().encode(wrapped) else {
            return "null"
        }
        return String(decoding: data, as: UTF8.self)
    }

    public init?(rawValue: String) {
        guard rawValue != "null",
              let data = rawValue.data(using: .utf8),
              let value = try? JSONDecoder().decode(Wrapped.self, from: data) else {
            self = nil
            return
        }
        self = value
    }
}
