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

    func updateUIView(_ uiView: WKWebView, context: Context) {
        uiView.load(URLRequest(url: url))
    }
}

struct NoticeWebViewDetail: View {
    
    @State private var webView = WKWebView()
    
    @Environment(\.presentationMode) var presentationMode
    
    let urlString: String
    
    var body: some View {
        VStack {
            NoticeWebView(url: URL(string: urlString)!)
            HStack(spacing: 70) {
                Button(action: {
                    self.webView.goBack()
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(Color.Gray400)
                }
                Button(action: {
                    self.webView.goForward()
                }) {
                    Image(systemName: "chevron.right")
                        .foregroundColor(Color.Gray400)
                }
                Button(action: {
                    UIPasteboard.general.string = urlString
                }) {
                    Image(systemName: "square.and.arrow.up")
                        .foregroundColor(Color.Gray400)
                }
                Button(action: {
                    self.webView.reload()
                }) {
                    Image(systemName: "arrow.clockwise")
                        .foregroundColor(Color.Gray400)
                }
            }
            .padding()
            .background(Color.white)
            .frame(height: 44)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(
            leading: Button(action: {
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "xmark")
                    .foregroundColor(Color.Gray400)
            })
        .toolbar {
            ToolbarItem(placement: .principal) {
                VStack {
                    Text("동양미래대학교")
                        .font(.Medium16)
                        .accentColor(Color.Gray500)
                    Text("www.dongyang.ac.kr")
                        .font(.Medium12)
                        .accentColor(Color.Gray300)
                }
            }
        }
    }
}
