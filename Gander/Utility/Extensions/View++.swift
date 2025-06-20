//
//  View++.swift
//  Gender
//
//  Created by KavinduDissanayake on 2025-06-20.
//

import SwiftUI

// MARK: UI Design Helper functions
extension View{

    func hAlign(_ alignment: Alignment)->some View{
        self
            .frame(maxWidth: .infinity, alignment: alignment)
    }

    func vAlign(_ alignment: Alignment)->some View{
        self
            .frame(maxHeight: .infinity, alignment: alignment)
    }

    func hLeading()->some View{
        self
            .frame(maxWidth: .infinity, alignment: .leading)
    }

    func hTrailing()->some View{
        self
            .frame(maxWidth: .infinity, alignment: .trailing)
    }

    func hCenter()->some View{
        self
            .frame(maxWidth: .infinity, alignment: .center)
    }

    // MARK: Safe Area
    func getSafeArea()->UIEdgeInsets{
        guard let screen = UIApplication.shared.connectedScenes.first as? UIWindowScene else{
            return .zero
        }

        guard let safeArea = screen.windows.first?.safeAreaInsets else{
            return .zero
        }

        return safeArea
    }
}
