//
//  NotificationView.swift
//  DMU-iOS
//
//  Created by 이예빈 on 1/14/24.
//

import SwiftUI

struct NotificationView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @StateObject private var viewModel = NotificationViewModel()
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(viewModel.notices) { notice in
                    NotificationListView(notice: notice)
                }
                .padding(.bottom, 8)
            }
            .padding(20)
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle("키워드 알림함")
            .navigationBarItems(leading: homeBackButton, trailing: keywordEditButton)
        }
    }
    
    private var homeBackButton: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "chevron.backward")
                .foregroundColor(Color.gray500)
        }
    }
    
    private var keywordEditButton: some View {
        Button(action: {
            viewModel.editKeywords()
        }) {
            Text("완료")
                .font(.Medium16)
                .foregroundColor(Color.gray500)
        }
    }
}

// MARK: - 알림 리스트뷰
struct NotificationListView: View {
    var notice: Notice
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(notice.noticeTitle)
                    .font(.Medium16)
                    .foregroundColor(Color.gray500)
                    .fixedSize(horizontal: false, vertical: true)
                
                HStack {
                    Text(notice.noticeType)
                        .font(.SemiBold12)
                        .foregroundColor(Color.gray400)
                    
                    Divider()
                        .background(Color.gray300)
                    
                    Text(notice.noticeKeyword)
                        .font(.SemiBold12)
                        .foregroundColor(Color.gray400)
                }
                .padding(.top, 0)
            }
            
            Spacer()
            
            Image(systemName: "chevron.right")
                .foregroundColor(Color.gray400)
                .frame(width: 24, height: 24)
        }
        .padding(20)
        .overlay(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray300, lineWidth: 1)
        )
    }
}


#Preview {
    NotificationView()
}
