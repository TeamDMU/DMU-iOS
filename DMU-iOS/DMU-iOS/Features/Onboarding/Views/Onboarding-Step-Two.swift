//
//  Onboarding-Step-Two.swift
//  DMU-iOS
//
//  Created by 이예빈 on 12/28/23.
//

import SwiftUI

struct Onboarding_Step_Two: View {
    
    @State private var selectedKeywords:[String] = []
    @State private var isStepThreeViewActive = false
    
    @ObservedObject var userSettings = UserSettings()
    
    @Binding var isFirstLanching: Bool
    
    var body: some View {
        
        VStack {
            OnboardingStepTwoTitleView()
            
            OnboardingStepTwoProgressBarView()
            
            CustomKeyword(selectedKeywords: $selectedKeywords)
            
            Spacer()
            
            CustomButton(title: "다음", action: {
                if !selectedKeywords.isEmpty {
                    self.userSettings.selectedKeywordsContents = selectedKeywords
                    self.isStepThreeViewActive = true
                }
                print("\(userSettings.selectedKeywordsContents)가 저장되었습니다.")
            }, isEnabled: !selectedKeywords.isEmpty)
            .padding(.bottom, 20)
            .navigationDestination(isPresented: $isStepThreeViewActive) {
                Onboarding_Step_Three(isFirstLanching: $isFirstLanching)
            }
        }
        .navigationBarBackButtonHidden(true)
    }
}

// MARK: - 온보딩 화면 2단계 타이틀 뷰
struct OnboardingStepTwoTitleView: View {
    
    var body: some View {
        VStack {
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    HStack(spacing: 0){
                        Text("키워드")
                            .font(.Bold32)
                            .foregroundColor(Color.Blue300)
                        
                        Text("를 설정하면,")
                            .font(.Bold32)
                            .foregroundColor(Color.Gray500)
                    }
                    Text("해당 키워드의 공지를 볼 수 있어요.")
                        .font(.Bold24)
                        .foregroundColor(Color.Gray500)
                }
            }
            .padding(.leading, -20)
        }
        .padding(.top, 60)
    }
}

// MARK: - 온보딩 화면 2단계 프로그레스바
struct OnboardingStepTwoProgressBarView: View {
    
    var body: some View {
        VStack(alignment: .center) {
            HStack {
                Circle()
                    .frame(width: 12, height: 12)
                    .foregroundColor(Color.Gray300)
                
                Spacer()
                
                Circle()
                    .frame(width: 12, height: 12)
                    .foregroundColor(Color.Blue300)
                
                Spacer()
                
                Circle()
                    .frame(width: 12, height: 12)
                    .foregroundColor(Color.Gray300)
            }
            .frame(width: 240, height: 2)
            .background(Color.Gray300)
            
            HStack {
                Text("키워드 설정")
                    .padding(.top, 10)
                    .foregroundColor(Color.Blue300)
                    .font(.Bold16)
            }
            
        }
        .padding(.top, 40)
    }
}

#Preview {
    Onboarding_Step_Two(isFirstLanching: .constant(true))
}
