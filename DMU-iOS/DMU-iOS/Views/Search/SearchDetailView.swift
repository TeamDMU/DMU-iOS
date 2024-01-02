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
        ScrollView {
            LazyVStack(alignment: .leading) {
                ForEach(sampleData.filter({ "\($0.title)".contains(viewModel.searchText) || viewModel.searchText.isEmpty }), id: \.id) { item in
                    SearchResultRow(item: item, viewModel: viewModel)
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
                                HStack(spacing: 0) {
            Button(action: {
                // 뒤로가기 버튼 누르면 검색 화면 초기화
                viewModel.resetSearchState()
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Image(systemName: "chevron.backward")
                    .foregroundColor(Color.blue300)
            }
            .padding(.leading, 20)
            
            HStack {
                TextField("검색어를 입력하세요.", text: $viewModel.searchText)
                    .frame(width: 240)
                    .padding(12)
                    .padding(.leading, 40)
                    .font(.Medium16)
                    .foregroundColor(Color.blue300)
                    .background(Color.blue100)
                    .cornerRadius(8)
                    .padding(.horizontal, 20)
                    .overlay(
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.blue300)
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

#Preview {
    SearchDetailView(viewModel: SearchViewModel())
}
