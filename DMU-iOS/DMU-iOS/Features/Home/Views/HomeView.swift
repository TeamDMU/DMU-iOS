//
//  HomeView.swift
//  DMU-iOS
//
//  Created by 이예빈 on 12/29/23.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject var viewModel = NoticeViewModel(userSettings: UserSettings())
    
    @EnvironmentObject var userSettings: UserSettings
    
    var body: some View {
        NavigationStack {
            VStack {
                HomeTopBarView(viewModel: viewModel)
                
                NoticeTabBarView(viewModel: viewModel)
                
                NoticeTabSwipeView(viewModel: viewModel, userSettings: _userSettings)
            }
            .onReceive(userSettings.$selectedDepartment) { _ in
                viewModel.objectWillChange.send()
            }
            .navigationDestination(isPresented: $viewModel.isNavigationToNotification){
                NotificationView()
            }
            
            if viewModel.isDepartmentNoticeLoading {
                ProgressView()
                    .scaleEffect(1)
                    .progressViewStyle(CircularProgressViewStyle(tint: .gray400))
            }
        }
    }
}

// MARK: - 공지사항 화면 상단바(로고 및 알림 버튼)
struct HomeTopBarView: View {
    
    let viewModel: NoticeViewModel
    
    var body: some View {
        HStack {
            Image("logo")
                .resizable()
                .frame(width: 128, height: 33)
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

// MARK: - 공지사항 화면 상단탭바(대학 공지, 학과 공지)
struct NoticeTabBarView: View {
    
    @ObservedObject var viewModel: NoticeViewModel
    
    var body: some View {
        HStack {
            NoticeTabBarItem(title: .university, viewModel: viewModel)
            NoticeTabBarItem(title: .department, viewModel: viewModel)
        }
        .padding(.top, 13)
        .frame(maxWidth: .infinity)
        .background(Color.white)
    }
}

struct NoticeTabBarItem: View {
    
    var title: NoticeTab
    
    @ObservedObject var viewModel: NoticeViewModel
    
    var body: some View {
        VStack {
            Text(title.rawValue)
                .font(.Bold16)
                .foregroundColor(viewModel.selectedTab == title ? Color.Blue300 : Color.Gray400)
                .onTapGesture {
                    viewModel.selectedTab = title
                }
            Rectangle()
                .frame(height: 2)
                .foregroundColor(viewModel.selectedTab == title ? Color.Blue300 : Color.clear)
        }
    }
}

struct NoticeTabSwipeView: View {
    
    @ObservedObject var viewModel: NoticeViewModel
    
    @EnvironmentObject var userSettings: UserSettings
    
    var body: some View {
        TabView(selection: $viewModel.selectedTab) {
            HomeUniversityNoticeListView(universityNotices: viewModel.universityNotices, viewModel: viewModel)
                .tag(NoticeTab.university)
            HomeDepartmentNoticeListView(departmentNotices: viewModel.filterDepartmentNotices(department: userSettings.selectedDepartment), viewModel: viewModel)
                .tag(NoticeTab.department)
        }
        .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
    }
}

// MARK: - 대학, 학과 공지사항 리스트뷰
struct HomeUniversityNoticeListView: View {
    let universityNotices: [UniversityNotice]
    let viewModel: NoticeViewModel
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                ForEach(universityNotices) { notice in
                    NavigationLink(destination: NoticeWebViewDetail(urlString: notice.noticeURL)){
                        NoticeSingleView(notices: notice)
                    }
                    Divider().background(Color.Gray200)
                }
            }
        }
        .padding(.horizontal, 0)
        .background(Color.white)
    }
}

struct HomeDepartmentNoticeListView: View {
    let departmentNotices: [DepartmentNotice]
    var viewModel: NoticeViewModel
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                ForEach(departmentNotices) { notice in
                    NavigationLink(destination: NoticeWebViewDetail(urlString: notice.noticeURL)){
                        NoticeSingleView(notices: notice)
                    }
                    .onAppear {
                        if self.departmentNotices.isLastItem(notice) {
                            self.viewModel.loadNextPageIfNotLoading()
                        }
                    }
                    Divider().background(Color.Gray200)
                }
            }
        }
        .padding(.horizontal, 0)
        .background(Color.white)
    }
}


struct NoticeSingleView: View {
    let notices: any NoticeProtocol

    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(notices.noticeTitle)
                    .font(.Medium16)
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.leading) // 여러 줄 정렬
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            HStack {
                Text(notices.noticeDate.formattedString)
                    .font(.Regular12)
                    .foregroundColor(Color.Gray400)
                
                Text(notices.noticeStaffName)
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

extension Array where Element == DepartmentNotice {
    func isLastItem(_ item: DepartmentNotice) -> Bool {
        guard let lastItem = self.last else {
            return false
        }
        return lastItem == item
    }
}

#Preview {
    HomeView()
        .environmentObject(UserSettings())
}
