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
        TabItem(id: 0, title: "Home", icon: "house", selectedIcon: "house.fill"),
        TabItem(id: 1, title: "Search", icon: "magnifyingglass"),
        TabItem(id: 2, title: "Profile", icon: "person", selectedIcon: "person.fill")
    ]
    
    var body: some View {
        VStack {
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
            
            Spacer()
            
            // Custom Tab Bar
            CustomTabBar(
                selectedTab: $selectedTab,
                items: tabItems,
                onFloatingButtonTap: {
                    // Handle floating button tap
                    print("Floating button tapped!")
                }
            )
        }
        .background(Color(.systemGray6))
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
            TabItem(id: 0, title: "Home", icon: "house", selectedIcon: "house.fill"),
            TabItem(id: 1, title: "Search", icon: "magnifyingglass"),
            TabItem(id: 2, title: "Profile", icon: "person", selectedIcon: "person.fill")
        ],
        onFloatingButtonTap: { print("Floating button tapped in preview") }
    )
    .padding()
}

#Preview {
    VStack(spacing: 20) {
        TabBarItem(
            item: TabItem(id: 0, title: "Home", icon: "house", selectedIcon: "house.fill"),
            isSelected: true,
            selectedColor: .blue,
            unselectedColor: .gray,
            action: {}
        )

        TabBarItem(
            item: TabItem(id: 1, title: "Search", icon: "magnifyingglass"),
            isSelected: false,
            selectedColor: .blue,
            unselectedColor: .gray,
            action: {}
        )
    }
    .padding()
}




// MARK: - Sample Views
