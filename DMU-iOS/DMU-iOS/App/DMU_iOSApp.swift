//
//  DMU_iOSApp.swift
//  DMU-iOS
//
//  Created by 이예빈 on 12/26/23.
//

import SwiftUI

@main
struct DMU_iOSApp: App {
    
    init() {
        //MARK: 탭바 배경화면 투명도 제거
        let appearanceTabBar = UITabBarAppearance()
        
        appearanceTabBar.configureWithOpaqueBackground()
        appearanceTabBar.backgroundColor = UIColor.white
        
        UITabBar.appearance().barTintColor = UIColor.white
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().standardAppearance = appearanceTabBar
        
        //MARK: 네비게이션바 투명도, 그림자 제거
        let appearanceNavigationBar = UINavigationBarAppearance()
        
        appearanceNavigationBar.configureWithOpaqueBackground()
        appearanceNavigationBar.titleTextAttributes = [.foregroundColor: UIColor.gray500]
        appearanceNavigationBar.backgroundColor = .white
        appearanceNavigationBar.shadowColor = nil
        
        UINavigationBar.appearance().standardAppearance = appearanceNavigationBar
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(UserSettings())
        }
    }
}
