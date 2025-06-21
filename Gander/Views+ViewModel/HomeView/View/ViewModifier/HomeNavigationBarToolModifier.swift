//
//  HomeNavigationBarToolModifier.swift
//  Gender
//
//  Created by KavinduDissanayake on 2025-06-20.
//

import SwiftUI
// MARK: - Custom Toolbar Modifier

struct HomeNavigationBarToolModifier: ViewModifier {
    @ObservedObject var viewModel: HomeViewModel

    func body(content: Content) -> some View {
        content
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text("Ganders")
                       .fontBold(24)
                }

                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    Menu {
                        Picker("Filter by Status", selection: $viewModel.selectedLabel) {
                            Text("All").tag("All")
                            Text("Verified").tag(FactCheckStatus.verified.rawValue)
                            Text("Unverified").tag(FactCheckStatus.unverified.rawValue)
                            Text("Misinterpretation").tag(FactCheckStatus.misinterpretation.rawValue)
                            Text("Reviewing").tag(FactCheckStatus.reviewing.rawValue)
                            Text("Unknown").tag(FactCheckStatus.unknown.rawValue)
                        }
                    } label: {
                        Image(.icDots)
                            .renderingMode(.template)

                    }

                    Button(action: {
                        // Handle notification action
                    }) {
                        Image(.icNotification)
                            .renderingMode(.template)
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
    }
}

extension View {
    func applyHomeNavigationBarTool(viewModel: HomeViewModel) -> some View {
        self.modifier(HomeNavigationBarToolModifier(viewModel: viewModel))
    }
}
