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
        VStack {
            switch viewModel.selectedTab {
            case .Home:
                HomeView(viewModel: NoticeViewModel(), userSettings: userSettings)
            case .Schedule:
                ScheduleView(viewModel: ScheduleViewModel())
            case .Meal:
                MealView(viewModel: MealViewModel())
            case .Settings:
                SettingView(viewModel: SettingViewModel(userSettings: userSettings))
            }
                        
            CustomTabView(selectedTab: $viewModel.selectedTab)
                .frame(height: 60)
        }
        .accentColor(Color.Blue300)
    }
}

// MARK: - 커스텀 탭바 뷰
struct CustomTabView: View {
    
    @Binding var selectedTab: Tab

    var body: some View {
        HStack {
            TabButton(tab: .Home, selectedTab: $selectedTab, image: "megaphone.fill", title: "공지")
            TabButton(tab: .Schedule, selectedTab: $selectedTab, image: "calendar", title: "일정")
            TabButton(tab: .Meal, selectedTab: $selectedTab, image: "fork.knife", title: "식단")
            TabButton(tab: .Settings, selectedTab: $selectedTab, image: "gearshape", title: "설정")
        }
        .frame(maxWidth: .infinity)
        .background(Color.white)
    }
}

// MARK: - 탭 버튼 뷰
struct TabButton: View {
    
    var tab: Tab
    @Binding var selectedTab: Tab
    var image: String
    var title: String
    
    var body: some View {
        Button(action: {
            selectedTab = tab
        }) {
            VStack(spacing: 4) {
                Image(systemName: image)
                    .foregroundColor(selectedTab == tab ? .Blue300 : .Gray400)
                
                Text(title)
                    .font(.Medium12)
                    .foregroundColor(selectedTab == tab ? .Blue300 : .Gray400)
                    .environment(\.sizeCategory, .large)
            }
        }
        .frame(maxWidth: .infinity)
    }
}
