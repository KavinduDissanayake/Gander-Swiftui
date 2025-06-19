//
//  AppSwipeManager.swift
//  Gender
//
//  Created by KavinduDissanayake on 2025-06-20.
//


import SwiftUI
import UIKit


class AppSwipeManager {
    static let shared = AppSwipeManager()
    var swipeEnabled = true
}

extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return  AppSwipeManager.shared.swipeEnabled  ?  viewControllers.count > 1 : false 
    }
}
