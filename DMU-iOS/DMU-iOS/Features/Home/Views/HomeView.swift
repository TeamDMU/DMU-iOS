//
//  HomeView.swift
//  DMU-iOS
//
//  Created by 이예빈 on 12/29/23.
//

import SwiftUI

struct HomeView: View {
    
    @State private var selectedTab = "대학공지"
    
    @ObservedObject var viewModel = NoticeViewModel(userSettings: UserSettings())
    
    @EnvironmentObject var userSettings: UserSettings
    
    var body: some View {
        NavigationStack {
            VStack {
                HomeTopBarView(viewModel: viewModel)
                
                HomeSelectNoticeTabView(selectedTab: $viewModel.selectedTab)
                
                HomeNoticeListView(notices: viewModel.filteredNotices(department: userSettings.selectedDepartment), viewModel: viewModel)
            }
            .onReceive(userSettings.$selectedDepartment) { _ in
                viewModel.objectWillChange.send()
            }
            .navigationDestination(isPresented: $viewModel.isNavigationToNotification){
                NotificationView()
            }
        }
    }
}

// MARK: - 상단바(로고 및 알림 버튼)
struct HomeTopBarView: View {
    
    let viewModel: NoticeViewModel
    
    var body: some View {
        HStack {
            Image("logo")
                .resizable()
                .frame(width: 75, height: 34)
                .padding(.leading)
            Spacer()
            HomeBellButton(viewModel: viewModel)
        }
    }
}

struct HomeBellButton: View {
    
    let viewModel: NoticeViewModel
    
    var body: some View {
        Button(action: viewModel.navigateToNotification) {
            Image(systemName: "bell")
                .resizable()
                .frame(width: 20, height: 22)
                .foregroundColor(Color.Blue300)
                .padding(.trailing)
        }
    }
}

// MARK: - 대학공지, 학부공지 탭
struct HomeSelectNoticeTabView: View {
    
    @Binding var selectedTab: String
    
    var body: some View {
        HStack {
            HomeSelectNoticeTabButton(title: "대학공지", selectedTab: $selectedTab)
            HomeSelectNoticeTabButton(title: "학부공지", selectedTab: $selectedTab)
        }
    }
}

struct HomeSelectNoticeTabButton: View {
    
    let title: String
    
    @Binding var selectedTab: String
    
    var body: some View {
        Button(action: {
            selectedTab = title
        }) {
            Text(title)
                .font(.Bold16)
                .foregroundColor(selectedTab == title ? Color.Blue300 : Color.Gray400)
                .frame(width: 196.5, height: 44)
                .background(Color.white)
                .overlay(
                    selectedTab == title ? Rectangle().frame(height: 2).padding(.top, 42).foregroundColor(Color.Blue300) : nil
                )
        }.buttonStyle(PlainButtonStyle())
    }
}

// MARK: - 공지사항 리스트뷰
struct HomeNoticeListView: View {
    
    let notices: [Notice]
    let viewModel: NoticeViewModel
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                ForEach(notices) { notice in
                    NavigationLink(destination: HomeDetailView(detailNotice: notice, homeDetailViewNavigationBarTitle: viewModel.selectedTab, viewModel: NoticeViewModel(userSettings: UserSettings()))){
                        HomeNoticeSingleView(notice: notice, viewModel: viewModel)
                    }
                    
                    Divider().background(Color.Gray200)
                }
            }
        }
        .padding(.horizontal, 0)
        .background(Color.white)
        
    }
}

struct HomeNoticeSingleView: View {
    
    let notice: Notice
    var viewModel: NoticeViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(notice.noticeTitle)
                    .font(.Medium16)
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.leading) // 여러 줄 정렬
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            HStack {
                Text(viewModel.formatDate(notice.noticeDate))
                    .font(.Regular12)
                    .foregroundColor(Color.Gray400)
                
                Text(notice.noticeStaffName)
                    .font(.Regular12)
                    .foregroundColor(Color.Gray400)
                    .padding(.leading, 12)
            }
            .padding(.top, 1)
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(0)
        .shadow(color: Color.gray, radius: 0, x: 0, y: 0)
    }
}

#Preview {
    HomeView()
        .environmentObject(UserSettings())
}
