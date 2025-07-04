//
//  Spacer+Extension.swift
//  PickMeDriverIOS
//
//  Created by Kavindu Dissanayake on 2024-12-15.
//

import SwiftUI

extension Spacer {
    @ViewBuilder static func width(_ value: CGFloat?) -> some View {
        switch value {
        case .some(let value): Spacer().frame(width: max(value, 0))
        case nil: Spacer()
        }
    }
    @ViewBuilder static func height(_ value: CGFloat?) -> some View {
        switch value {
        case .some(let value): Spacer().frame(height: max(value, 0))
        case nil: Spacer()
        }
    }
}
