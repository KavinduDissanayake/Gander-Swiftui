//
//  AlertManager.swift
//  Gander
//
//  Created by KavinduDissanayake on 2025-06-21.
//

import MijickPopups
import SwiftUI

public final class AlertManager {
    private init() {}

    @MainActor
    public static func showTopBanner(_ title: String,
                                     _ message: String? = nil,
                                     type: BannerType = .success,
                                     isShowCloseIcon: Bool = false,
                                     onDismiss: (() -> Void)? = nil) {
        Task {

            let data = BannerData(title: title,
                                  message: message,
                                  isShowCloseIcon: isShowCloseIcon,
                                  type: type)

            await BannerView(data: data)
                .dismissAfter(3.0)
                .present()
        }
    }

    public static func dismissAllAlerts() {
        Task {
            await PopupStack.dismissAllPopups(popupStackID: .init(rawValue: "shared"))
        }
    }
}
