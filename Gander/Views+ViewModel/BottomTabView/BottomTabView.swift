//
//  HomeView.swift
//  Gender
//
//  Created by KavinduDissanayake on 2025-06-20.
//

import SwiftUI

struct BottomTabView: View {
    @State private var selectedTab = 0

    // Define your tab items
    private let tabItems = [
        TabItem(id: 0, title: "Home", icon: "ic_home", selectedIcon: "ic_home_selected"),
        TabItem(id: 1, title: "Ganders", icon: "ic_paper", selectedIcon: "ic_paper_selected"),
        TabItem(id: 2, title: "Profile", icon: "ic_profile", selectedIcon: "ic_profile_selected")
    ]

    var body: some View {
        VStack(spacing: .zero) {
            // Your main content here
            TabView(selection: $selectedTab) {
                HomeView()
                    .tag(0)

                SearchView()
                    .tag(1)

                ProfileView()
                    .tag(2)
            }
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))

            // Custom Tab Bar
            CustomTabBar(
                selectedTab: $selectedTab,
                items: tabItems
            )
        }
        .background(Color.background)
        .ignoresSafeArea(.keyboard)
        .tint(.tint)
    }
}

#Preview {
    BottomTabView()
}

#Preview {
    CustomTabBar(
        selectedTab: .constant(0),
        items: [
            TabItem(id: 0, title: "Home", icon: "ic_home", selectedIcon: "ic_home_selected"),
            TabItem(id: 1, title: "Ganders", icon: "ic_paper", selectedIcon: "ic_paper_selected"),
            TabItem(id: 2, title: "Profile", icon: "ic_profile", selectedIcon: "ic_profile_selected")
        ]
    )
    .padding()
}

#Preview {
    VStack(spacing: 20) {
        TabBarItem(
            item: TabItem(id: 0, title: "Home", icon: "ic_home", selectedIcon: "ic_home_selected"),
            isSelected: true,
            selectedColor: .blue,
            unselectedColor: .gray,
            action: {}
        )

        TabBarItem(
            item: TabItem(id: 1, title: "Ganders", icon: "ic_paper", selectedIcon: "ic_paper_selected"),
            isSelected: false,
            selectedColor: .blue,
            unselectedColor: .gray,
            action: {}
        )
    }
    .padding()
}

// MARK: - Sample Views
