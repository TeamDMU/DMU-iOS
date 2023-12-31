//
//  HomeView.swift
//  DMU-iOS
//
//  Created by 이예빈 on 12/29/23.
//

import SwiftUI

struct HomeView: View {
    
    @State private var selectedTab = "대학공지"
    
    // 날짜 형식을 바꿔주는 함수
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter.string(from: date)
    }
    
    var body: some View {
        VStack {
            HStack {
                Image("logo")
                    .resizable()
                    .frame(width: 75, height: 34)
                    .padding(.leading)
                Spacer()
                Button(action: {
                    
                }) {
                    Image(systemName: "bell")
                        .resizable()
                        .frame(width: 20, height: 22)
                        .foregroundColor(.blue300)
                        .padding(.trailing)
                }
                    
            }
            
            HStack {
                Button(action: {
                    selectedTab = "대학공지"
                }) {
                    Text("대학 공지")
                        .font(.Bold16)
                        .foregroundColor(selectedTab == "대학공지" ? .blue300 : .gray400)
                        .frame(width: 196.5, height: 44)
                        .background(Color.white)
                        .overlay(
                            selectedTab == "대학공지" ? Rectangle().frame(height: 2).padding(.top, 42).foregroundColor(.blue300) : nil
                        )
                }.buttonStyle(PlainButtonStyle())
                
                Button(action: {
                    selectedTab = "학부공지"
                }) {
                    Text("학부 공지")
                        .font(.Bold16)
                        .foregroundColor(selectedTab == "학부공지" ? .blue300 : .gray400)
                        .frame(width: 196.5, height: 44)
                        .background(Color.white)
                        .overlay(
                            selectedTab == "학부공지" ? Rectangle().frame(height: 2).padding(.top, 42).foregroundColor(.blue300) : nil
                        )
                }.buttonStyle(PlainButtonStyle())
            }
            
            ScrollView {
                LazyVStack(alignment: .leading) {
                    ForEach(sampleData.filter { $0.noticeType == selectedTab }) { notice in
                        VStack(alignment: .leading) {
                            Text(notice.title)
                                .font(.Medium16)
                                .foregroundColor(.black)
                            HStack {
                                Text(formatDate(notice.date))
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
                        
                        Divider().background(Color.gray200)
                    }
                }
            }
            .padding(.horizontal, 0)
            .background(Color.white)
        }
        .background(Color.white.ignoresSafeArea())
    
    }
}

#Preview {
    HomeView()
}
