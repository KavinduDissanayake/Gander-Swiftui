//
//  ViewRouter.swift
//  Gender
//
//  Created by KavinduDissanayake on 2025-06-20.
//
import SwiftUI

// MARK: - Cache Keys
enum CacheKeys {
    static let isAuthenticated = "isAuthenticated"
    static let articleHisotry = "articalHistory"
}




// MARK: - Routing Enum
enum Roots {
    case login
    case bottomTabs
}

// MARK: - View Router
class ViewRouter: ObservableObject {
    @Published var currentRoot: Roots = .login

    @AppStorage(CacheKeys.isAuthenticated) private var isAuthenticated: Bool = false

    static let shared = ViewRouter()

    fileprivate init() {
        currentRoot = isAuthenticated ? .bottomTabs : .login
    }
}



