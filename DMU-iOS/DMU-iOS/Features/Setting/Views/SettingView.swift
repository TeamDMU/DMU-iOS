//
//  SettingView.swift
//  DMU-iOS
//
//  Created by 이예빈 on 12/31/23.
//

import SwiftUI

struct SettingView: View {
    
    @StateObject var viewModel: SettingViewModel
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading, spacing: 20) {
                Text("설정")
                    .font(.system(size: 20, weight: .semibold))
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .center)
                    .foregroundColor(Color.Gray500)
                
                Text("대학 공지")
                    .font(.SemiBold15)
                    .foregroundColor(Color.Blue300)
                    .padding(.horizontal, 20)
                
                Toggle(isOn: $viewModel.isUniversityNoticeOn) {
                    Text("알림 설정")
                        .font(.Medium18)
                        .foregroundColor(Color.Gray500)
                }
                .toggleStyle(SwitchToggleStyle(tint: Color.Blue300))
                .padding(.horizontal, 20)
                
                Divider()
                
                Text("학과 공지")
                    .font(.SemiBold15)
                    .foregroundColor(Color.Blue300)
                    .padding(.horizontal, 20)
                
                Toggle(isOn: $viewModel.isDepartmentNoticeOn) {
                    Text("알림 설정")
                        .font(.Medium18)
                        .foregroundColor(Color.Gray500)
                }
                .toggleStyle(SwitchToggleStyle(tint: Color.Blue300))
                .padding(.horizontal, 20)
                
                HStack {
                    Text("학과 설정")
                        .font(.Medium18)
                        .foregroundColor(Color.Gray500)
                    
                    Spacer()
                    
                    Button(action: viewModel.navigateToDepartment) {
                        HStack {
                            Text(viewModel.userSettings.selectedDepartment)
                                .font(.Medium14)
                                .foregroundColor(Color.Gray400)
                            Image(systemName: "chevron.right")
                                .foregroundColor(Color.Gray500)
                        }
                    }
                }
                .padding(.horizontal, 20)
                
                Divider()
                
                Text("앱 정보")
                    .font(.SemiBold15)
                    .foregroundColor(Color.Blue300)
                    .padding(.horizontal, 20)
                
                Button(action: {}) {
                    Text("문의하기")
                        .font(.Medium18)
                        .foregroundColor(Color.Gray500)
                }
                .padding(.horizontal, 20)
                
                HStack {
                    Text("앱 버전")
                        .font(.Medium18)
                        .foregroundColor(Color.Gray500)
                    
                    Spacer()
                    
                    Text("1.0.0")
                        .font(.Medium14)
                        .foregroundColor(Color.Gray400)
                }
                .padding(.horizontal, 20)
                
                Divider()
                
                Spacer()
            }
            .navigationDestination(isPresented: $viewModel.isNavigatingToSettingDepartmentView) {
                SettingDepartmentView(viewModel: viewModel)
            }
        }
    }
}

#Preview {
    SettingView(viewModel: SettingViewModel(userSettings: UserSettings()))
}
