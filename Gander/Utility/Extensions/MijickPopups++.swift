//
//  MijickPopups(++.swift
//  Gender
//
//  Created by KavinduDissanayake on 2025-06-20.
//
import SwiftUI
import MijickPopups

extension View {
    func applyMijickPopups() -> some View {
        self.registerPopups {
            $0.center {
                $0.backgroundColor(Color(uiColor: .secondarySystemBackground))
                    .cornerRadius(20)
                    .popupHorizontalPadding(20)
            }
            .vertical {
                $0.backgroundColor(Color(uiColor: .secondarySystemBackground))
                    .cornerRadius(20)
                    .enableStacking(true)
                    .tapOutsideToDismissPopup(true)
            }
        }
    }
}
