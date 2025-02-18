//
//  TabBarView.swift
//  DMU-iOS
//
//  Created by 이예빈 on 12/31/23.
//

import SwiftUI

// MARK: - 탭바 ViewModel
class TabBarViewModel: ObservableObject {
    
    @Published var selectedTab: Tab = .Home
}

// MARK: - 탭 목록
enum Tab: String {
    
    case Home, Schedule, Meal, Settings
}

// MARK: - 메인화면 탭바 뷰
struct TabBarView: View {
    
    @ObservedObject var userSettings = UserSettings()
    
    @ObservedObject var viewModel: TabBarViewModel
    
    var body: some View {
        TabView(selection: $viewModel.selectedTab) {
            HomeView(viewModel: NoticeViewModel(), userSettings: UserSettings())
                .tabItem {
                    Image(systemName: "megaphone.fill")
                    Text("공지")
                }
                .tag(Tab.Home)
            
            ScheduleView(viewModel: ScheduleViewModel())
                .tabItem {
                    Image(systemName: "calendar")
                    Text("일정")
                }
                .tag(Tab.Schedule)
            
            MealView(viewModel: MealViewModel())
                .tabItem {
                    Image(systemName: "fork.knife")
                    Text("식단")
                }
                .tag(Tab.Meal)
            
            SettingView(viewModel: SettingViewModel(userSettings: UserSettings()))
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("설정")
                }
                .tag(Tab.Settings)
        }
        .accentColor(Color.Blue300)
    }
}

