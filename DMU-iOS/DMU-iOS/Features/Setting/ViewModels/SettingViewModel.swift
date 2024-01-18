//
//  SettingViewModel.swift
//  DMU-iOS
//
//  Created by 이예빈 on 1/5/24.
//

import Foundation

class SettingViewModel: ObservableObject {
    
    @Published var isUniversityNoticeOn: Bool = false
    @Published var isDepartmentNoticeOn: Bool = false
    @Published var isNavigatingToSettingDepartmentView: Bool = false
    @Published var settingDepartment: String? = nil
    
    var userSettings: UserSettings
    
    init(userSettings: UserSettings) {
        self.userSettings = userSettings
    }
    
    //MARK: 학과 설정 화면으로 네비게이션 이동
    func navigateToDepartment() {
        isNavigatingToSettingDepartmentView = true
    }
    
    //MARK: 학과 선택
    func selectDepartment(_ department: String) {
        if settingDepartment == department {
            settingDepartment = nil
        } else {
            settingDepartment = department
        }
    }
    
    //MARK: 선택 학과 저장
    func saveDepartment() {
        guard let department = settingDepartment else {
            return
        }
        userSettings.selectedDepartment = department
    }
    
}
