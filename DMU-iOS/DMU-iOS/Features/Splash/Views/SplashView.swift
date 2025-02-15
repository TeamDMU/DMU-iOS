//
//  SplashView.swift
//  DMU-iOS
//
//  Created by 이예빈 on 12/26/23.
//

import SwiftUI

struct SplashView: View {
    
    var body: some View {
        ZStack {
            Color.white
            
            VStack {
                Spacer()
                
                Image("SplashIcon")
                    .resizable()
                    .frame(width: 100, height: 81.33)
                    .padding(.bottom, 40)
                
                HStack(spacing: 0) {
                    Text("우리 ")
                        .font(.Bold30)
                        .foregroundColor(Color.Gray600)
                        .environment(\.sizeCategory, .large)
                    
                    Text("학교 공지")
                        .font(.Bold30)
                        .foregroundColor(Color.Blue300)
                        .environment(\.sizeCategory, .large)
                    
                    Text("를")
                        .font(.Bold30)
                        .foregroundColor(Color.Gray600)
                        .environment(\.sizeCategory, .large)
                }
                
                HStack(spacing: 0) {
                    Text("가장 빠르게")
                        .font(.Bold30)
                        .foregroundColor(Color.Blue400)
                        .environment(\.sizeCategory, .large)
                    
                    Text(".")
                        .font(.Bold30)
                        .foregroundColor(Color.Yellow100)
                        .environment(\.sizeCategory, .large)
                }
                
                Spacer()
                
                Text("ⓒ 2024. Team DMU All rights reserved.")
                    .font(.Light12)
                    .foregroundColor(Color.Gray400)
                    .environment(\.sizeCategory, .large)
                    .padding(.bottom, 54)
            }
        }
        .ignoresSafeArea()
    }
}

#Preview {
    SplashView()
}
