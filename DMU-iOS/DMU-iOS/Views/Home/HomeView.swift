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
                TopBarView()
                
                TabSelectionView(selectedTab: $viewModel.selectedTab)
                
                NoticeListView(notices: viewModel.filteredNotices(department: userSettings.selectedDepartment), viewModel: viewModel)
            }
            .onReceive(userSettings.$selectedDepartment) { _ in
                viewModel.objectWillChange.send()
            }
        }
    }
}

// MARK: - 상단바(로고 및 알림 버튼)
struct TopBarView: View {
    var body: some View {
        HStack {
            Image("logo")
                .resizable()
                .frame(width: 75, height: 34)
                .padding(.leading)
            Spacer()
            BellButton()
        }
    }
}

struct BellButton: View {
    var body: some View {
        Button(action: {}) {
            Image(systemName: "bell")
                .resizable()
                .frame(width: 20, height: 22)
                .foregroundColor(.blue300)
                .padding(.trailing)
        }
    }
}

// MARK: - 대학공지, 학부공지 탭
struct TabSelectionView: View {
    @Binding var selectedTab: String
    
    var body: some View {
        HStack {
            TabButton(title: "대학공지", selectedTab: $selectedTab)
            TabButton(title: "학부공지", selectedTab: $selectedTab)
        }
    }
}

struct TabButton: View {
    let title: String
    @Binding var selectedTab: String
    
    var body: some View {
        Button(action: {
            selectedTab = title
        }) {
            Text(title)
                .font(.Bold16)
                .foregroundColor(selectedTab == title ? .blue300 : .gray400)
                .frame(width: 196.5, height: 44)
                .background(Color.white)
                .overlay(
                    selectedTab == title ? Rectangle().frame(height: 2).padding(.top, 42).foregroundColor(.blue300) : nil
                )
        }.buttonStyle(PlainButtonStyle())
    }
}

// MARK: - 공지사항 리스트뷰
struct NoticeListView: View {
    let notices: [Notice]
    let viewModel: NoticeViewModel
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                ForEach(notices) { notice in
                    NavigationLink(destination: HomeDetailView(detailNotice: notice, homeDetailViewNavigationBarTitle: viewModel.selectedTab, viewModel: NoticeViewModel(userSettings: UserSettings()))){
                        NoticeView(notice: notice, viewModel: viewModel)
                    }
                    Divider().background(Color.gray200)
                }
            }
        }
        .padding(.horizontal, 0)
        .background(Color.white)
        
    }
}

struct NoticeView: View {
    let notice: Notice
    var viewModel: NoticeViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(notice.noticeTitle)
                .font(.Medium16)
                .foregroundColor(.black)
                .multilineTextAlignment(.leading) // 여러 줄 정렬
            
            HStack {
                Text(viewModel.formatDate(notice.noticeDate))
                    .font(.Regular12)
                    .foregroundColor(.gray400)
                
                Text(notice.noticeStaffName)
                    .font(.Regular12)
                    .foregroundColor(.gray400)
                    .padding(.leading, 12)
            }
            .padding(.top, 1)
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(0)
        .shadow(color: .gray, radius: 0, x: 0, y: 0)
    }
}

#Preview {
    HomeView()
            .environmentObject(UserSettings())
}
