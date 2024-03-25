//
//  SettingViewModel.swift
//  DMU-iOS
//
//  Created by 이예빈 on 1/5/24.
//

import Foundation

class SettingViewModel: ObservableObject {
    
    @Published var settingDepartment: String? = nil
    @Published var userSettings: UserSettings
    
    init(userSettings: UserSettings) {
        self.userSettings = userSettings
        self.settingDepartment = userSettings.selectedDepartment
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
