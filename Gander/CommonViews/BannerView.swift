//
//  BannerView.swift
//  Gander
//
//  Created by KavinduDissanayake on 2025-06-21.
//

import SwiftUI
import MijickPopups

public struct BannerView: TopPopup {
    let data: BannerData

    public func configurePopup(config: LocalConfigVertical.Top) -> LocalConfigVertical.Top {
        return config.backgroundColor(.clear)
    }

    public var body: some View {
        HStack(alignment: .top, spacing: 12) {
            data.type.icon
                .resizable()
                .renderingMode(.template)
                .scaledToFit()
                .frame(width: 20, height: 20)
                .foregroundStyle(data.type.textColor)

            VStack(alignment: .leading, spacing: 4) {
                Text(data.title)
                    .font(.headline)
                    .foregroundStyle(data.type.textColor)
                    .hLeading()

                if let msg = data.message {
                    Text(msg)
                        .font(.subheadline)
                        .foregroundStyle(data.type.textColor.opacity(0.9))
                }
            }

            if data.isShowCloseIcon {
                Button {
                    Task {
                        await dismissPopup(BannerView.self)
                    }
                } label: {
                    Image(systemName: "xmark")
                        .imageScale(.small)
                        .foregroundStyle(data.type.textColor)
                        .padding(6)
                }
                .background(.white.opacity(0.1))
                .clipShape(Circle())
            }
        }
        .padding()
        .background(data.type.backgroundColor)
        .cornerRadius(14)
        .shadow(color: .black.opacity(0.1), radius: 5, x: 0, y: 2)
        .padding(.horizontal)
    }

}

#Preview("Success Banner") {
    BannerView(data: BannerData(title: "Success", message: "This is a success banner.", isShowCloseIcon: true, type: .success))
}

#Preview("Error Banner") {
    BannerView(data: BannerData(title: "Error", message: "Something went wrong.", isShowCloseIcon: true, type: .error))
}
