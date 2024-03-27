//
//  SettingWebView.swift
//  DMU-iOS
//
//  Created by 이예빈 on 3/27/24.
//

import SwiftUI

import WebKit

struct SettingWebViewDetail: View {
    
    let urlString: String
        
    @Environment(\.presentationMode) var presentationMode
        
    var body: some View {
        VStack {
            CustomWebView(url: URL(string: urlString)!)
                .edgesIgnoringSafeArea(.all)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading: Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "xmark")
                    .foregroundColor(Color.Gray400)
            })
    }
}


struct CustomWebView: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.load(URLRequest(url: url))
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
    }

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }
}

