//
//  RootView.swift
//  Gender
//
//  Created by KavinduDissanayake on 2025-06-20.
//

import SwiftUI
// MARK: - Root View
struct RootView: View {
    @EnvironmentObject var router: ViewRouter

    var body: some View {
        // Since the target audience is iOS 15, we use NavigationView instead of NavigationStack
        NavigationView {
            containedView(roots: router.currentRoot)
                .id(router.currentRoot)
        } //: NavigationView
        .navigationViewStyle(.stack)
    }

    @ViewBuilder
    func containedView(roots: Roots) -> some View {
        switch router.currentRoot {
        case .login:
            LoginView()
        case .bottomTabs:
            BottomTabView()
        }
    }
}

struct RouteModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .environmentObject(ViewRouter.shared)
    }
}

extension View {
    func applyViewRoutes() -> some View {
        modifier(RouteModifier())
    }
}

#Preview {
    RootView()
        .applyViewRoutes()
}
