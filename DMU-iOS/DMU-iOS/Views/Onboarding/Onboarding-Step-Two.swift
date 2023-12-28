//
//  Onboarding-Step-Two.swift
//  DMU-iOS
//
//  Created by 이예빈 on 12/28/23.
//

import SwiftUI

struct Onboarding_Step_Two: View {
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    HStack(spacing: 0){
                        Text("키워드")
                            .font(.Bold32)
                            .foregroundColor(.blue300)
                        Text("를 설정하면,")
                            .font(.Bold32)
                            .foregroundColor(.gray500)
                    }
                    Text("해당 키워드의 공지를 볼 수 있어요.")
                        .font(.Bold24)
                        .foregroundColor(.gray500)
                }
            }
            .padding(.leading, -20)
        }
        .padding(.top, 60)
        
        VStack(alignment: .center) {
            HStack {
                Circle()
                    .frame(width: 12, height: 12)
                    .foregroundColor(.gray300)
                
                Spacer()
                Circle()
                    .frame(width: 12, height: 12)
                    .foregroundColor(.blue300)
                
                Spacer()
                Circle()
                    .frame(width: 12, height: 12)
                    .foregroundColor(.gray300)
            }
            .frame(width: 240, height: 2)
            .background(.gray300)
            
            HStack {
                Text("키워드 설정")
                    .padding(.top, 10)
                    .foregroundColor(.blue300)
                    .font(.Bold16)
            }
            
        }
        .padding(.top, 40)
        
        CustomKeyword()
        
        Spacer()
        CustomButton(title: "다음", action: { print("버튼 클릭!") }, isEnabled: true)
        
    }
}

#Preview {
    Onboarding_Step_Two()
}
