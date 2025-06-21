//
//  LogType.swift
//  Gender
//
//  Created by KavinduDissanayake on 2025-06-20.
//

import Foundation

enum LogType: String {
    case error
    case warning
    case success
    case info
    case action
    case canceled
}

class Logger {
    static let isLoggingEnabled = Constant.isLoggingEnabled()

    static func log(logType: LogType, title: String? = nil, message: String) {
        guard isLoggingEnabled else { return }

        let emoji = emojiForType(logType)
        let displayTitle = title ?? logType.rawValue.capitalized

        print("\n\(emoji)\(displayTitle)-------------------------------------------------------\(emoji)\n\(message)\n\(emoji)--------------------------------------------------------------\(emoji)")
    }

    private static func emojiForType(_ type: LogType) -> String {
        switch type {
        case .error: return "❌"
        case .warning: return "⚠️"
        case .success: return "✅"
        case .info: return "ℹ️"
        case .action: return "🛠️"
        case .canceled: return "🚫"
        }
    }
}
