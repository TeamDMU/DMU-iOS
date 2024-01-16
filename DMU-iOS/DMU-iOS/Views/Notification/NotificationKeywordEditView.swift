//
//  NotificationKeywordEditView.swift
//  DMU-iOS
//
//  Created by 이예빈 on 1/16/24.
//

import SwiftUI

struct NotificationKeywordEditView: View {
    
    @State private var selectedKeywords = [String: [String]]()
    @Binding var showingKeywordEditView: Bool
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    showingKeywordEditView = false
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(Color.black)
                        .padding()
                }
                
                Spacer()
                
                Text("키워드 설정")
                    .font(.SemiBold20)
                    .foregroundColor(Color.Gray500)
                
                Spacer()
                Spacer()
            }
            
            CustomKeyword(selectedKeywords: $selectedKeywords)
            
            Spacer()
            
            CustomButton(
                title: "완료",
                action: {
                    
                },
                isEnabled: true
            )
            
        }
    }
}
