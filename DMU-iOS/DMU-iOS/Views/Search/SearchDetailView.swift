//
//  SearchDetailView.swift
//  DMU-iOS
//
//  Created by 이예빈 on 1/2/24.
//

import SwiftUI

struct SearchDetailView: View {
    @ObservedObject var viewModel: SearchViewModel
    
    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading) {
                ForEach(sampleData.filter({ "\($0.title)".contains(viewModel.searchText) || viewModel.searchText.isEmpty }), id: \.id) { item in
                    SearchResultRow(item: item, viewModel: viewModel)
                }
            }
        }
        .navigationTitle("검색 결과")
    }
}

#Preview {
    SearchDetailView(viewModel: SearchViewModel())
}
