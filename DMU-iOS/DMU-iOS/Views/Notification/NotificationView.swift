//
//  NotificationView.swift
//  DMU-iOS
//
//  Created by 이예빈 on 1/14/24.
//

import SwiftUI

struct NotificationView: View {
    @State var notices: [Notice] = sampleData
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(notices) { notice in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(notice.noticeTitle)
                                .font(.Medium16)
                                .foregroundColor(Color.Gray500)
                                .fixedSize(horizontal: false, vertical: true)
                            
                            HStack{
                                Text(notice.noticeType)
                                    .font(.SemiBold12)
                                    .foregroundColor(Color.Gray400)
                                
                                Divider()
                                    .background(Color.Gray300)
                                
                                Text(notice.noticeKeyword)
                                    .font(.SemiBold12)
                                    .foregroundColor(Color.Gray400)
                            }
                            .padding(.top, 0)
                        }
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .foregroundColor(Color.Gray400)
                            .frame(width: 24, height: 24)
                    }
                    .padding(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.Gray300, lineWidth: 1)
                    )
                }
                .padding(.bottom, 8)
            }
            .padding(20)
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle("키워드 알림함")
            .navigationBarItems(leading: homeBackButton, trailing: keywordEditButton)
        }
    }
    
    @ViewBuilder
    var homeBackButton: some View {
        Button(action: {
            self.presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "chevron.backward")
                .foregroundColor(Color.Gray500)
        }
    }
    
    @ViewBuilder
    var keywordEditButton: some View {
        Button(action: {
            
        }) {
            Text("완료")
                .font(.Medium16)
                .foregroundColor(Color.Gray500)
        }
    }
}

#Preview {
    NotificationView()
}
