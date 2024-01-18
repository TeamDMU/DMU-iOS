//
//  TabBarView.swift
//  DMU-iOS
//
//  Created by 이예빈 on 12/31/23.
//

import SwiftUI

class TabBarViewModel: ObservableObject {
    
    @Published var selectedTab: Tab = .home
}

enum Tab: String {
    
    case home, search, schedule, meal, settings
}

struct TabBarView: View {
    
    @ObservedObject var viewModel: TabBarViewModel
    
    var body: some View {
        NavigationStack {
            TabView(selection: $viewModel.selectedTab) {
                
                // MARK: 공지사항 화면
                HomeView()
                    .tabItem {
                        Image(systemName: "house")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(Color.Gray400)
                        
                        Text("공지")
                            .font(.Medium12)
                            .foregroundColor(Color.Gray400)
                    }
                    .tag(Tab.home)
                    .environmentObject(UserSettings())
                    .onAppear {
                        
                    }
                
                // MARK: 검색 화면
                SearchView(viewModel: SearchViewModel())
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(Color.Gray400)
                        
                        Text("검색")
                            .font(.Medium12)
                            .foregroundColor(Color.Gray400)
                    }
                    .tag(Tab.search)
                
                // MARK: 일정 화면
                ScheduleView()
                    .tabItem {
                        Image(systemName: "calendar")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(Color.Gray400)
                        
                        Text("일정")
                            .font(.Medium12)
                            .foregroundColor(Color.Gray400)
                    }
                    .tag(Tab.schedule)
                
                // MARK: 식단 화면
                MealView()
                    .tabItem {
                        Image(systemName: "fork.knife")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(Color.Gray400)
                        
                        Text("식단")
                            .font(.Medium12)
                            .foregroundColor(Color.Gray400)
                    }
                    .tag(Tab.meal)
                
                // MARK: 설정 화면
                SettingView(viewModel: SettingViewModel(userSettings: UserSettings()))
                    .tabItem {
                        Image(systemName: "gearshape")
                            .resizable()
                            .frame(width: 24, height: 24)
                            .foregroundColor(Color.Gray400)
                        
                        Text("설정")
                            .font(.Medium12)
                            .foregroundColor(Color.Gray400)
                    }
                    .tag(Tab.settings)
            }
            .accentColor(Color.Blue300)
            .ignoresSafeArea(edges: .all)
        }
    }
}

#Preview {
    TabBarView(viewModel: TabBarViewModel())
}
