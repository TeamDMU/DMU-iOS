//
//  ContentView.swift
//  DMU-iOS
//
//  Created by 이예빈 on 12/26/23.
//

import SwiftUI

import UserNotifications

struct ContentView: View {
    
    @State var showSplashView = true
    @State var showOnboardingView = false
    
    @StateObject var tabBarViewModel = TabBarViewModel()
    
    // 사용자 안내 온보딩 페이지를 앱 설치 후 최초 실행할 때만 띄우도록 하는 변수.
    // @AppStorage에 저장되어 앱 종료 후에도 유지됨.
    @AppStorage("_isFirstLaunching") var isFirstLaunching: Bool = true
    
    var body: some View {
        VStack {
            if showSplashView {
                SplashView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            withAnimation {
                                showSplashView = false
                                
                                if isFirstLaunching {
                                    showOnboardingView = true
                                }
                            }
                            requestNotificationAuthorization()
                        }
                    }
            } else if showOnboardingView {
                Onboarding_Step_One(isFirstLanching: $isFirstLaunching)
            } else {
                TabBarView(viewModel: tabBarViewModel)
            }
        }
    }
}

func requestNotificationAuthorization() {
    let center = UNUserNotificationCenter.current()
    center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
        if let error = error {
            print("Authorization request error: \(error)")
        }
    }
}

#Preview {
    ContentView()
}
