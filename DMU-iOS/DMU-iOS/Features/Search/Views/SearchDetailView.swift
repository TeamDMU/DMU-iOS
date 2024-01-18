//
//  SearchDetailView.swift
//  DMU-iOS
//
//  Created by 이예빈 on 1/2/24.
//

import SwiftUI

struct SearchDetailView: View {
    
    @ObservedObject var viewModel: SearchViewModel
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        NavigationStack {
            // MARK: 모든 검색 결과 리스트 뷰
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(sampleData.filter({ item in
                        item.noticeTitle.range(of: viewModel.searchText, options: .caseInsensitive) != nil || viewModel.searchText.isEmpty
                    }), id: \.id) { item in
                        SearchResultSingleView(item: item, viewModel: viewModel)
                    }
                }
            }
            .padding(.top, 10)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading:
                                    HStack(spacing: 0) {
                // MARK: 검색 디테일 화면 뒤로 가기 버튼
                Button(action: {
                    viewModel.resetSearchState()
                    self.presentationMode.wrappedValue.dismiss()
                }) {
                    Image(systemName: "chevron.backward")
                        .foregroundColor(Color.Blue300)
                }
                .padding(.leading, 20)
                
                HStack {
                    TextField("검색어를 입력하세요.", text: $viewModel.searchText)
                        .frame(width: 240)
                        .padding(12)
                        .padding(.leading, 40)
                        .font(.Medium16)
                        .foregroundColor(Color.Blue300)
                        .background(Color.Blue100)
                        .cornerRadius(8)
                        .padding(.horizontal, 20)
                        .overlay(
                            HStack {
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(Color.Blue300)
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    .padding(.leading, 36)
                                    .padding(.trailing, 36)
                            }
                        )
                }
            }
            )
        }
    }
}

#Preview {
    SearchDetailView(viewModel: SearchViewModel())
}
