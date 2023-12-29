//
//  ContentView.swift
//  DMU-iOS
//
//  Created by 이예빈 on 12/26/23.
//

import SwiftUI
import UserNotifications

struct ContentView: View {
    
    @State var showMainView = false
    
    var body: some View {
        VStack {
            if showMainView {
                Text("main")
            } else {
                SplashView()
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            requestNotificationAuthorization()
                            withAnimation {
                                showMainView = true
                            }
                        }
                    }
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
