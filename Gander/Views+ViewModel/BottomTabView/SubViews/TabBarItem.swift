//
//  TabBarItem.swift
//  Gender
//
//  Created by KavinduDissanayake on 2025-06-20.
//
import SwiftUI

// MARK: - Tab Bar Item
struct TabBarItem: View {
    let item: TabItem
    let isSelected: Bool
    let selectedColor: Color
    let unselectedColor: Color
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(isSelected ? (item.selectedIcon ?? item.icon) : item.icon)
                    .renderingMode(.template)
                    .fontRegular(16)
                    .foregroundColor(isSelected ? selectedColor : unselectedColor)

                Text(item.title)
                    .font(isSelected ? .semiBoldFont(withSize: 12) : .regularFont(withSize: 12))
                    .foregroundColor(isSelected ? selectedColor : unselectedColor)
            }
            .scaleEffect(isSelected ? 1.1 : 1.0)
            .animation(.easeInOut(duration: 0.2), value: isSelected)
        }
        .frame(maxWidth: .infinity)
    }
}

// MARK: - Preview
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
