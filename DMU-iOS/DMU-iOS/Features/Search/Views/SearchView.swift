//
//  SearchView.swift
//  DMU-iOS
//
//  Created by 이예빈 on 12/31/23.
//

import SwiftUI

struct SearchView: View {
    
    @ObservedObject var viewModel: SearchViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                SearchBarView(viewModel: viewModel)
                
                SearchResults(viewModel: viewModel)
            }
        }
    }
}

// MARK: - 검색 화면 검색바 뷰
struct SearchBarView: View {
    
    @StateObject var viewModel: SearchViewModel
    
    var body: some View {
        HStack {
            TextField("검색어를 입력하세요.", text: $viewModel.searchText, onCommit: {
                viewModel.performSearch()
                withAnimation {
                    viewModel.endSearchEditing()
                    hideKeyboard()
                }
            })
            .padding(12)
            .padding(.horizontal, 28)
            .font(.Medium16)
            .foregroundColor(Color.Blue300)
            .background(Color.Blue100)
            .cornerRadius(8)
            .overlay(
                SearchBarOverlay(viewModel: viewModel)
            )
            .padding(.horizontal, 20)
            .onTapGesture {
                withAnimation {
                    viewModel.startSearchEditing()
                }
            }
            
            if viewModel.isEditing {
                SearchCancelButton(viewModel: viewModel)
            }
        }
    }
}

struct SearchBarOverlay: View {
    
    @StateObject var viewModel: SearchViewModel
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(Color.Blue300)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 12)
                .padding(.trailing, 12)
            
            if viewModel.isEditing && !viewModel.searchText.isEmpty {
                SearchClearTextButton(viewModel: viewModel)
            }
        }
    }
}

// MARK: - 검색창 텍스트 삭제 및 키보드 내리는 버튼
struct SearchCancelButton: View {
    
    @StateObject var viewModel: SearchViewModel
    
    var body: some View {
        Button(action: {
            viewModel.clearText()
            hideKeyboard()
            withAnimation {
                viewModel.isEditing = false
            }
        }) {
            Text("취소")
                .padding(.trailing, 20)
                .padding(.leading, -10)
                .font(.Medium16)
                .foregroundColor(Color.Blue300)
                .transition(.move(edge: .trailing))
        }
    }
}

// MARK: - 검색바 뷰 내부 텍스트 삭제 버튼
struct SearchClearTextButton: View {
    
    @StateObject var viewModel: SearchViewModel
    
    var body: some View {
        Button(action: {
            viewModel.clearText()
        }) {
            Image(systemName: "multiply.circle.fill")
                .foregroundColor(Color.Gray400)
                .padding(.trailing, 12)
        }
    }
}

// MARK: - 검색 결과 리스트 뷰
struct SearchResults: View {
    
    @StateObject var viewModel: SearchViewModel
    
    var body: some View {
        ScrollView {
            if viewModel.shouldShowResults {
                SearchResultsListView(viewModel: viewModel)
            }
        }
    }
}

struct SearchResultsListView: View {
    
    @StateObject var viewModel: SearchViewModel
    
    @State private var navigateToSearchDetail = false
    
    var body: some View {
        VStack {
            LazyVStack(alignment: .leading) {
                ForEach(viewModel.filteredUniversityNotices, id: \.id) { notice in
                    NavigationLink(destination: NoticeWebViewDetail(urlString: notice.notice.noticeURL)){
                        SearchResultSingleView(notice: notice.notice, viewModel: viewModel)
                    }
                }
                
                ForEach(viewModel.filteredDepartmentNotices, id: \.id) { notice in
                    NavigationLink(destination: NoticeWebViewDetail(urlString: notice.notice.noticeURL)){
                        SearchResultSingleView(notice: notice.notice, viewModel: viewModel)
                    }
                }
            }
        }
    }
}

struct SearchResultSingleView: View {
    
    var notice: Notice
    
    @StateObject var viewModel: SearchViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack{
                Text(notice.noticeTitle)
                    .font(.Medium16)
                    .foregroundColor(Color.black)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            HStack {
                Text("\(viewModel.formatDate(notice.noticeDate))")
                    .font(.Regular12)
                    .foregroundColor(Color.Gray400)
                
                Text(notice.noticeStaffName)
                    .font(.Regular12)
                    .foregroundColor(Color.Gray400)
            }
            .padding(.top, 1)
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(0)
        .shadow(color: .gray, radius: 0, x: 0, y: 0)
        
        Divider().background(Color.Gray200)
    }
}

// MARK: - 키보드 숨기기
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#Preview {
    SearchView(viewModel: SearchViewModel())
}
