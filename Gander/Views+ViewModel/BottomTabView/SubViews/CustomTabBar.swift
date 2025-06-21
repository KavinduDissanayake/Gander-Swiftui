//
//  CustomTabBar.swift
//  Gender
//
//  Created by KavinduDissanayake on 2025-06-20.
//
import SwiftUI

// MARK: - Custom Tab Bar View
struct CustomTabBar: View {
    @Binding var selectedTab: Int
    let items: [TabItem]
    // Customizable properties
    var tabBarHeight: CGFloat = 50
    var backgroundColor: Color = Color(.systemBackground)
    var selectedColor: Color = .tint
    var unselectedColor: Color = Color(.systemGray)
    var shadowColor: Color = Color.black.opacity(0.1)

    var body: some View {
        VStack {
            Divider()
                .frame(height: 1)

            HStack(spacing: 0) {
                Spacer()
                ForEach(Array(items.enumerated()), id: \.element.id) { _, item in

                    TabBarItem(
                        item: item,
                        isSelected: selectedTab == item.id,
                        selectedColor: selectedColor,
                        unselectedColor: unselectedColor
                    ) {
                        selectedTab = item.id
                    }
                }
                Spacer()
            }
            .frame(height: tabBarHeight)
        }
    }
}

#Preview {
    CustomTabBar(
        selectedTab: .constant(0),
        items: [
            TabItem(id: 0, title: "Home", icon: "house", selectedIcon: "house.fill"),
            TabItem(id: 1, title: "Search", icon: "magnifyingglass"),
            TabItem(id: 2, title: "Profile", icon: "person", selectedIcon: "person.fill")
        ]
    )
    .padding()
}
