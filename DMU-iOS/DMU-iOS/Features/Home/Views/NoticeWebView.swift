//
//  NoticeWebView.swift
//  DMU-iOS
//
//  Created by 이예빈 on 2/8/24.
//

import SwiftUI
import WebKit

struct NoticeWebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.load(URLRequest(url: url))
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {}
}

