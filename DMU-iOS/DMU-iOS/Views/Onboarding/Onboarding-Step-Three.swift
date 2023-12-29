//
//  Onboarding-Step-Three.swift
//  DMU-iOS
//
//  Created by 이예빈 on 12/29/23.
//

import SwiftUI

struct Onboarding_Step_Three: View {
    @State private var isOn = false
    
    var body: some View {
        
        OnboardingTitleView3()
        
        ProgressBarView3()
        
        NotificationSettingsView(isOn: $isOn)
        
        Spacer()
        
        CustomButton(title: "알림 설정 및 시작하기", action: { print("버튼 클릭!") }, isEnabled: true)
    }
}

struct OnboardingTitleView3: View {
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    HStack(spacing: 0){
                        Text("키워드 알림 설정")
                            .font(.Bold32)
                            .foregroundColor(.blue300)
                        Text("으로")
                            .font(.Bold32)
                            .foregroundColor(.gray500)
                    }
                    Text("중요한 공지사항을 놓치지 마세요!")
                        .font(.Bold24)
                        .foregroundColor(.gray500)
                }
            }
            .padding(.leading, -20)
        }
        .padding(.top, 60)
        .navigationBarBackButtonHidden(true)
    }
}

struct ProgressBarView3: View {
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                Circle()
                    .frame(width: 12, height: 12)
                    .foregroundColor(.gray300)
                
                Spacer()
                Circle()
                    .frame(width: 12, height: 12)
                    .foregroundColor(.gray300)
                
                Spacer()
                Circle()
                    .frame(width: 12, height: 12)
                    .foregroundColor(.blue300)
            }
            .frame(width: 240, height: 2)
            .background(.gray300)
            
            HStack {
                Spacer()
                Text("알림 설정")
                    .padding(.top, 10)
                    .foregroundColor(.blue300)
                    .font(.Bold16)
            }
            .padding(.trailing, 49)
            
        }
        .padding(.top, 40)
    }
}

struct NotificationSettingsView: View {
    @Binding var isOn : Bool
    
    var body: some View {
        VStack {
            HStack {
                HStack{
                    Image(systemName: "bell.fill")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(isOn ? .blue300 : .gray400)
                        .padding(.trailing, 16)
                    
                    Text("키워드 알림 설정")
                        .font(.SemiBold20)
                        .foregroundColor(isOn ? .blue300 : .gray400)
                    
                    Spacer()
                    
                    Toggle(isOn: $isOn) {
                        Text("")
                    }
                    .labelsHidden()
                    .toggleStyle(SwitchToggleStyle(tint: .blue300))
                }
                .frame(width: 240, height: 31)
            }
            .padding()
            .frame(width: 320, height: 80)
            .background(Color.white)
            .cornerRadius(15)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.blue300, lineWidth: 2))
            .shadow(color: Color.blue300.opacity(0.3), radius: 30, x: 0, y: 1)
        }
        .padding(.top, 96)
    }
}

#Preview {
    Onboarding_Step_Three()
}
