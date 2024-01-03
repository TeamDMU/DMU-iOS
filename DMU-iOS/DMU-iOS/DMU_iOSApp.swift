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
        let appearanceTabBar = UITabBarAppearance()
        appearanceTabBar.configureWithOpaqueBackground()
        appearanceTabBar.backgroundColor = .white
        UITabBar.appearance().standardAppearance = appearanceTabBar
        
        let appearanceNavigationBar = UINavigationBarAppearance()
        appearanceNavigationBar.configureWithOpaqueBackground()
        appearanceNavigationBar.backgroundColor = .white
        appearanceNavigationBar.shadowColor = nil
        UINavigationBar.appearance().standardAppearance = appearanceNavigationBar
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
