//
//  WebView.swift
//  Gander
//
//  Created by KavinduDissanayake on 2025-06-22.
//
import SwiftUI
import Foundation
import WebKit

struct WebView: UIViewRepresentable {
    let url: URL

    init(_ url: URL) {
        self.url = url
    }

    func makeUIView(context: Context) -> some UIView {
        let webView = WKWebView()
        webView.load(URLRequest(url: url))
        return webView
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {}
}

struct InAppWebView: View {
    let url: URL?
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        Group {
                   if let url = url {
                       WebView(url)
                   } else {
                       Text("Invalid URL")
                           .foregroundColor(.secondary)
                   }
               }
    }
}

#Preview("InAppWebView") {
    InAppWebView(url: URL(string: "https://example.com")!)
}
