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
        VStack {
            SearchBar(viewModel: viewModel)
            SearchResults(viewModel: viewModel)
        }
    }
}

struct SearchBar: View {
    @ObservedObject var viewModel: SearchViewModel

    var body: some View {
        HStack {
            TextField("검색어를 입력하세요.", text: $viewModel.searchText)
                .padding(12)
                .padding(.horizontal, 28)
                .font(.Medium16)
                .foregroundColor(Color.blue300)
                .background(Color.blue100)
                .cornerRadius(8)
                .overlay(
                    SearchBarOverlay(viewModel: viewModel)
                )
                .padding(.horizontal, 20)
                .onTapGesture {
                    withAnimation {
                        viewModel.isEditing = true
                    }
                }

            if viewModel.isEditing {
                CancelButton(viewModel: viewModel)
            }
        }
    }
}

struct SearchBarOverlay: View {
    @ObservedObject var viewModel: SearchViewModel

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.blue300)
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 12)
                .padding(.trailing, 12)

            if !viewModel.searchText.isEmpty {
                ClearTextButton(viewModel: viewModel)
            }
        }
    }
}

struct CancelButton: View {
    @ObservedObject var viewModel: SearchViewModel

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
                .foregroundColor(Color.blue300)
                .transition(.move(edge: .trailing))
        }
    }
}

struct ClearTextButton: View {
    @ObservedObject var viewModel: SearchViewModel

    var body: some View {
        Button(action: {
            viewModel.clearText()
        }) {
            Image(systemName: "multiply.circle.fill")
                .foregroundColor(.gray400)
                .padding(.trailing, 12)
        }
    }
}

struct SearchResults: View {
    @ObservedObject var viewModel: SearchViewModel

    var body: some View {
        ScrollView {
            if !viewModel.searchText.isEmpty {
                SearchResultsList(viewModel: viewModel)
            }
        }
    }
}

struct SearchResultsList: View {
    @ObservedObject var viewModel: SearchViewModel

    var body: some View {
        LazyVStack(alignment: .leading) {
            ForEach(sampleData.filter({ "\($0.title)".contains(viewModel.searchText) || viewModel.searchText.isEmpty }), id: \.id) { item in
                SearchResultRow(item: item, viewModel: viewModel)
            }
        }
    }
}

struct SearchResultRow: View {
    var item: Notice
    @ObservedObject var viewModel: SearchViewModel

    var body: some View {
        VStack(alignment: .leading) {
            Text(item.title)
                .font(.Medium16)
                .foregroundColor(.black)
            HStack {
                Text("\(viewModel.formatDate(item.date))")
                    .font(.Regular12)
                    .foregroundColor(.gray400)

                Text(item.staffName)
                    .font(.Regular12)
                    .foregroundColor(.gray400)
            }
            .padding(.top, 1)
        }
        .padding(16)
        .background(Color.white)
        .cornerRadius(0)
        .shadow(color: .gray, radius: 0, x: 0, y: 0)

        Divider().background(Color.gray200)
    }
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#Preview {
    SearchView(viewModel: SearchViewModel())
}
