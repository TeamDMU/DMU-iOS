//
//  ContentView.swift
//  DMU-iOS
//
//  Created by 이예빈 on 12/26/23.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    
    @State private var showSplashView = true
    @State private var showOnboardingView = false
    @StateObject private var tabBarViewModel = TabBarViewModel()
    @AppStorage("_isFirstLaunching") private var isFirstLaunching: Bool = true
    
    var body: some View {
        VStack {
            if showSplashView {
                splashView
            } else if showOnboardingView {
                Onboarding_Step_One(isFirstLanching: $isFirstLaunching)
            } else {
                TabBarView(viewModel: tabBarViewModel)
            }
        }
    }
    
    private var splashView: some View {
        SplashView()
            .onAppear {
                handleSplashView()
            }
    }
    
    private func handleSplashView() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            withAnimation {
                showSplashView = false
                if isFirstLaunching {
                    showOnboardingView = true
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
