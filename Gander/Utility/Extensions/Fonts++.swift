//
//  Fonts++.swift
//  Gander
//
//  Created by KavinduDissanayake on 2025-06-22.
//

import SwiftUI

extension Font {
    static func ultraLightFont(withSize size: CGFloat) -> Font {
        return Font.system(size: size, weight: .ultraLight)
    }

    static func thinFont(withSize size: CGFloat) -> Font {
        return Font.system(size: size, weight: .thin)
    }

    static func lightFont(withSize size: CGFloat) -> Font {
        return Font.system(size: size, weight: .light)
    }

    static func regularFont(withSize size: CGFloat) -> Font {
        return Font.system(size: size, weight: .regular)
    }

    static func mediumFont(withSize size: CGFloat) -> Font {
        return Font.system(size: size, weight: .medium)
    }

    static func semiBoldFont(withSize size: CGFloat) -> Font {
        return Font.system(size: size, weight: .semibold)
    }

    static func boldFont(withSize size: CGFloat) -> Font {
        return Font.system(size: size, weight: .bold)
    }

    static func heavyFont(withSize size: CGFloat) -> Font {
        return Font.system(size: size, weight: .heavy)
    }

    static func blackFont(withSize size: CGFloat) -> Font {
        return Font.system(size: size, weight: .black)
    }
}

extension View {
    func fontUltraLight(_ size: CGFloat) -> some View {
        self.font(.ultraLightFont(withSize: size))
    }

    func fontThin(_ size: CGFloat) -> some View {
        self.font(.thinFont(withSize: size))
    }

    func fontLight(_ size: CGFloat) -> some View {
        self.font(.lightFont(withSize: size))
    }

    func fontRegular(_ size: CGFloat) -> some View {
        self.font(.regularFont(withSize: size))
    }

    func fontMedium(_ size: CGFloat) -> some View {
        self.font(.mediumFont(withSize: size))
    }

    func fontSemiBold(_ size: CGFloat) -> some View {
        self.font(.semiBoldFont(withSize: size))
    }

    func fontBold(_ size: CGFloat) -> some View {
        self.font(.boldFont(withSize: size))
    }

    func fontHeavy(_ size: CGFloat) -> some View {
        self.font(.heavyFont(withSize: size))
    }

    func fontBlack(_ size: CGFloat) -> some View {
        self.font(.blackFont(withSize: size))
    }
}
