//
//  BannerType.swift
//  Gander
//
//  Created by KavinduDissanayake on 2025-06-21.
//

import SwiftUI

public enum BannerType {
    case success, error

    public var backgroundColor: Color {
        switch self {
        case .success: return .emeraldGreen
        case .error: return .carmineRed
        }
    }

    public var textColor: Color {
        return .white
    }

    public var icon: Image {
        switch self {
        case .success: return Image(systemName: "checkmark.circle")
        case .error: return Image(systemName: "xmark.octagon")
        }
    }
}
