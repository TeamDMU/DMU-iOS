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
        TabView(selection: $viewModel.selectedTab) {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.gray400)
                    Text("공지")
                        .font(.Medium12)
                        .foregroundColor(.gray400)
                }
                .tag(Tab.home)
            
            SearchView(viewModel: SearchViewModel())
                .tabItem {
                    Image(systemName: "magnifyingglass")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.gray400)
                    Text("검색")
                        .font(.Medium12)
                        .foregroundColor(.gray400)
                }
                .tag(Tab.search)
            
            ScheduleView()
                .tabItem {
                    Image(systemName: "calendar")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.gray400)
                    Text("일정")
                        .font(.Medium12)
                        .foregroundColor(.gray400)
                }
                .tag(Tab.schedule)
            
            MealView()
                .tabItem {
                    Image(systemName: "fork.knife")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.gray400)
                    Text("식단")
                        .font(.Medium12)
                        .foregroundColor(.gray400)
                }
                .tag(Tab.meal)
            
            SettingView()
                .tabItem {
                    Image(systemName: "gearshape")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(.gray400)
                    Text("설정")
                        .font(.Medium12)
                        .foregroundColor(.gray400)
                }
                .tag(Tab.settings)
        }
        .accentColor(.blue300)
        .ignoresSafeArea(edges: .all)
    }
}

#Preview {
    TabBarView(viewModel: TabBarViewModel())
}
