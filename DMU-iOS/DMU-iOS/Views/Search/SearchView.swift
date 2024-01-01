//
//  SearchView.swift
//  DMU-iOS
//
//  Created by 이예빈 on 12/31/23.
//

import SwiftUI

struct SearchView: View {
    
    @State private var searchText = ""
    @State private var isEditing = false
    
    var body: some View {
        VStack {
            HStack {
                TextField("검색어를 입력하세요.", text: $searchText)
                    .padding(12)
                    .padding(.horizontal, 28)
                    .font(.Medium16)
                    .foregroundColor(Color.blue300)
                    .background(Color.blue100)
                    .cornerRadius(8)
                    .overlay(
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.blue300)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 12)
                                .padding(.trailing, 12)
                            
                            if isEditing && !searchText.isEmpty {
                                Button(action: {
                                    self.searchText = ""
                                }) {
                                    Image(systemName: "multiply.circle.fill")
                                        .foregroundColor(.gray400)
                                        .padding(.trailing, 12)
                                }
                            }
                        }
                    )
                    .padding(.horizontal, 20)
                    .onTapGesture {
                        withAnimation {
                            self.isEditing = true
                        }
                    }
                
                if isEditing {
                    Button(action: {
                        self.isEditing = false
                        self.searchText = ""
                        hideKeyboard()
                    }) {
                        Text("취소")
                            .padding(.trailing, 20)
                            .font(.Medium16)
                            .foregroundColor(Color.blue300)
                            .transition(.move(edge: .trailing))
                    }
                }
            }
            
            ScrollView {
                if !searchText.isEmpty {
                    LazyVStack(alignment: .leading) {
                        ForEach(sampleData.filter({ "\($0.title)".contains(searchText) || searchText.isEmpty }), id: \.id) { item in
                            VStack(alignment: .leading) {
                                Text(item.title)
                                    .font(.Medium16)
                                    .foregroundColor(.black)
                                HStack {
                                    Text("\(formatDate(item.date))")
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
                }
            }
        }
    }
}

func formatDate(_ date: Date) -> String {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy.MM.dd"
    return formatter.string(from: date)
}

extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

#Preview {
    SearchView()
}
