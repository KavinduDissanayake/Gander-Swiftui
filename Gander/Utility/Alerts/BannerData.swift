//
//  BannerData.swift
//  Gander
//
//  Created by KavinduDissanayake on 2025-06-21.
//

import SwiftUI

public struct BannerData {
    public let title: String
    public let message: String?
    public let isShowCloseIcon: Bool
    public let type: BannerType

    public init(title: String,
                message: String? = nil,
                isShowCloseIcon: Bool = false,
                type: BannerType) {
        self.title = title
        self.message = message
        self.isShowCloseIcon = isShowCloseIcon
        self.type = type
    }
}
