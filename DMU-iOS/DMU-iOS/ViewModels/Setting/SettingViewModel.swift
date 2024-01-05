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
    @Published var isNavigatingToDepartment: Bool = false
    
    var userSettings: UserSettings

    init(userSettings: UserSettings) {
        self.userSettings = userSettings
    }
    
    func navigateToDepartment() {
        isNavigatingToDepartment = true
    }
}
