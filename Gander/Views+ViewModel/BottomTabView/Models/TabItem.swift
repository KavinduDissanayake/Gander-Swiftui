//
//  TabItem.swift
//  Gender
//
//  Created by KavinduDissanayake on 2025-06-20.
//
import Foundation

// MARK: - Tab Item Model
struct TabItem {
    let id: Int
    let title: String
    let icon: String
    let selectedIcon: String?

    init(id: Int, title: String, icon: String, selectedIcon: String? = nil) {
        self.id = id
        self.title = title
        self.icon = icon
        self.selectedIcon = selectedIcon
    }
}
