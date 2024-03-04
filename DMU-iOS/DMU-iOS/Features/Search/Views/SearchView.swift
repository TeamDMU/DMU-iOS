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
                
                if viewModel.isLoading {
                    ProgressView("Loading...")
                }
                
                if viewModel.shouldShowResults {
                    ScrollView {
                        SearchResultsListView(viewModel: viewModel)
                    }
                }
                
                Spacer()
            }
            .onTapGesture {
                hideKeyboard()
            }
        }
    }
}

// MARK: - 검색 화면 검색바 뷰
struct SearchBarView: View {
    
    @ObservedObject var viewModel: SearchViewModel
    
    var body: some View {
        HStack {
            TextField("검색어를 2글자 이상 입력하세요.", text: $viewModel.searchText, onCommit: {
                viewModel.performSearch()
                withAnimation {
                    viewModel.isEditing = false
                    hideKeyboard()
                }
            })
            .padding(EdgeInsets(top: 12, leading: 40, bottom: 12, trailing: 12))
            .background(Color.Blue100)
            .cornerRadius(8)
            .overlay(
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(Color.Blue300)
                        .padding(.leading, 12)

                    Spacer()

                    if viewModel.isEditing && !viewModel.searchText.isEmpty {
                        Button(action: {
                            viewModel.clearText()
                        }) {
                            Image(systemName: "multiply.circle.fill")
                                .foregroundColor(Color.Gray400)
                        }
                        .padding(.trailing, 12)
                    }
                }
            )
            .padding(.horizontal, 20)
            .onTapGesture {
                withAnimation {
                    viewModel.isEditing = true
                }
            }
            
            if viewModel.isEditing {
                Button(action: {
                    viewModel.clearText()
                    withAnimation {
                        viewModel.isEditing = false
                    }
                    hideKeyboard()
                }) {
                    Text("취소")
                        .font(.Medium16)
                        .foregroundColor(Color.Blue300)
                        .transition(.move(edge: .trailing))
                }
                .padding(.trailing, 20)
                .padding(.leading, -10)
            }
        }
    }
}


// MARK: - 검색 결과 리스트 뷰
struct SearchResultsListView: View {
    
    @ObservedObject var viewModel: SearchViewModel
        
    var body: some View {
        VStack {
            LazyVStack(alignment: .leading) {
                ForEach(viewModel.searchNotices, id: \.id) { notice in
                    NavigationLink(destination: NoticeWebViewDetail(urlString: notice.noticeURL)){
                        SearchResultSingleView(notice: notice)
                    }
                    Divider().background(Color.Gray200)
                }
            }
        }
    }
}

struct SearchResultSingleView: View {
    
    var notice: SearchNotice
    
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
                Text(notice.noticeDate.formattedString)
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
