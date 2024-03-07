//
//  Onboarding-Step-Three.swift
//  DMU-iOS
//
//  Created by 이예빈 on 12/29/23.
//

import SwiftUI

struct Onboarding_Step_Three: View {
    
    @State private var isNotificationOn = false
    @State private var isMainViewActive = false
    
    @Binding var isFirstLanching: Bool
    
    var body: some View {
        
        OnboardingStepThreeTitleView()
        
        OnboardingStepThreeProgressBarView()
        
        OnboardingStepThreeSetNotificationView(isOn: $isNotificationOn)
        
        Spacer()
        
        CustomButton(title: "시작하기", action: {
            self.isMainViewActive = true
            isFirstLanching.toggle()
        }, isEnabled: true)
        .padding(.bottom, 20)
        .fullScreenCover(isPresented: $isMainViewActive){
            TabBarView(viewModel: TabBarViewModel())
        }
    }
}

// MARK: - 온보딩 화면 3단계 타이틀 뷰
struct OnboardingStepThreeTitleView: View {
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    HStack(spacing: 0){
                        Text("키워드 알림 설정")
                            .font(.Bold32)
                            .foregroundColor(Color.Blue300)
                        
                        Text("으로")
                            .font(.Bold32)
                            .foregroundColor(Color.Gray500)
                    }
                    Text("중요한 공지사항을 놓치지 마세요!")
                        .font(.Bold24)
                        .foregroundColor(Color.Gray500)
                }
            }
            .padding(.leading, -20)
        }
        .padding(.top, 60)
        .navigationBarBackButtonHidden(true)
    }
}

// MARK: - 온보딩 화면 3단계 프로그레스바
struct OnboardingStepThreeProgressBarView: View {
    
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                Circle()
                    .frame(width: 12, height: 12)
                    .foregroundColor(Color.Gray300)
                
                Spacer()
                
                Circle()
                    .frame(width: 12, height: 12)
                    .foregroundColor(Color.Gray300)
                
                Spacer()
                
                Circle()
                    .frame(width: 12, height: 12)
                    .foregroundColor(Color.Blue300)
            }
            .frame(width: 240, height: 2)
            .background(Color.Gray300)
            
            HStack {
                Spacer()
                
                Text("알림 설정")
                    .padding(.top, 10)
                    .foregroundColor(Color.Blue300)
                    .font(.Bold16)
            }
            .padding(.trailing, 49)
            
        }
        .padding(.top, 40)
    }
}

// MARK: - 온보딩 화면 3단계 알림 설정 토글 뷰
struct OnboardingStepThreeSetNotificationView: View {
    
    @Binding var isOn : Bool
    
    var body: some View {
        VStack {
            HStack {
                HStack{
                    Image(systemName: "bell.fill")
                        .resizable()
                        .frame(width: 24, height: 24)
                        .foregroundColor(isOn ? Color.Blue300 : Color.Gray400)
                        .padding(.trailing, 16)
                    
                    Text("키워드 알림 설정")
                        .font(.SemiBold20)
                        .foregroundColor(isOn ? Color.Blue300 : Color.Gray400)
                    
                    Spacer()
                    
                    Toggle(isOn: $isOn) {
                        Text("")
                    }
                    .labelsHidden()
                    .toggleStyle(SwitchToggleStyle(tint: Color.Blue300))
                }
                .frame(width: 240, height: 31)
            }
            .padding()
            .frame(width: 320, height: 80)
            .background(Color.white)
            .cornerRadius(15)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.Blue300, lineWidth: 2))
            .shadow(color: Color.Blue300.opacity(0.3), radius: 30, x: 0, y: 1)
        }
        .padding(.top, 96)
    }
}

#Preview {
    Onboarding_Step_Three(isFirstLanching: .constant(true))
}
