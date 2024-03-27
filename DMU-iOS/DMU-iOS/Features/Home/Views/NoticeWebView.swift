//
//  NoticeWebView.swift
//  DMU-iOS
//
//  Created by 이예빈 on 2/8/24.
//

import SwiftUI

import WebKit

struct NoticeWebViewDetail: View {
    
    let urlString: String
    
    @State private var showShareSheet = false
    
    @Environment(\.presentationMode) var presentationMode
        
    var body: some View {
        VStack {
            WebView(url: URL(string: urlString)!)
                .edgesIgnoringSafeArea(.all)
            
            HStack(spacing: 60) {
                Button(action: {
                    NotificationCenter.default.post(name: NSNotification.Name("WebView.goBack"), object: nil)
                }) {
                    Image(systemName: "chevron.left")
                        .foregroundColor(Color.Gray400)
                        .frame(width: 44, height: 44)
                }
                Button(action: {
                    NotificationCenter.default.post(name: NSNotification.Name("WebView.goForward"), object: nil)
                }) {
                    Image(systemName: "chevron.right")
                        .foregroundColor(Color.Gray400)
                        .frame(width: 44, height: 44)
                }
                Button(action: {
                    UIPasteboard.general.string = urlString
                    showShareSheet = true
                }) {
                    Image(systemName: "square.and.arrow.up")
                        .foregroundColor(Color.Gray400)
                        .frame(width: 44, height: 44)
                }
                .sheet(isPresented: $showShareSheet) {
                    ActivityView(activityItems: [URL(string: urlString)!], applicationActivities: nil)
                }
                Button(action: {
                    NotificationCenter.default.post(name: NSNotification.Name("WebView.reload"), object: nil)
                }) {
                    Image(systemName: "arrow.clockwise")
                        .foregroundColor(Color.Gray400)
                        .frame(width: 44, height: 44)
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

struct ActivityView: UIViewControllerRepresentable {
    var activityItems: [Any]
    var applicationActivities: [UIActivity]?

    func makeUIViewController(context: Context) -> UIActivityViewController {
        let controller = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
        return controller
    }

    func updateUIViewController(_ uiViewController: UIActivityViewController, context: Context) {
        
    }
}


struct WebView: UIViewRepresentable {
    let url: URL
    
    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.load(URLRequest(url: url))
        context.coordinator.setup(webView: webView)
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
    }

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    class Coordinator: NSObject {
        func setup(webView: WKWebView) {
            NotificationCenter.default.addObserver(forName: NSNotification.Name("WebView.goBack"), object: nil, queue: .main) { _ in
                webView.goBack()
            }
            NotificationCenter.default.addObserver(forName: NSNotification.Name("WebView.goForward"), object: nil, queue: .main) { _ in
                webView.goForward()
            }
            NotificationCenter.default.addObserver(forName: NSNotification.Name("WebView.reload"), object: nil, queue: .main) { _ in
                webView.reload()
            }
        }
    }
}
