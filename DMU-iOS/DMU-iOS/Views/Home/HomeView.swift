//
//  HomeView.swift
//  DMU-iOS
//
//  Created by 이예빈 on 12/29/23.
//

import SwiftUI

struct HomeView: View {
    
    @State private var selectedTab = "대학공지"
    
    @ObservedObject var viewModel = NoticeViewModel()
    
    var body: some View {
        VStack {
            TopBarView()
            
            TabSelectionView(selectedTab: $viewModel.selectedTab)
            
            NoticeListView(notices: viewModel.filteredNotices(), viewModel: viewModel)
        }
        .background(Color.white.ignoresSafeArea())
        
    }
}

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

struct NoticeListView: View {
    let notices: [Notice]
    let viewModel: NoticeViewModel
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                ForEach(notices) { notice in
                    NoticeView(notice: notice, viewModel: viewModel)
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
            Text(notice.title)
                .font(.Medium16)
                .foregroundColor(.black)
            HStack {
                Text(viewModel.formatDate(notice.date))
                    .font(.Regular12)
                    .foregroundColor(.gray400)
                Text(notice.staffName)
                    .font(.Regular12)
                    .foregroundColor(.gray400)
                    .padding(.leading, 12)
            }
            .padding(.top, 10)
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(0)
        .shadow(color: .gray, radius: 0, x: 0, y: 0)
    }
}

#Preview {
    HomeView()
}
