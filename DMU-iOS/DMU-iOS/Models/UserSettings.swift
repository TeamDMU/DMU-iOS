//
//  UserSettings.swift
//  DMU-iOS
//
//  Created by 이예빈 on 1/5/24.
//

import Combine

class UserSettings: ObservableObject {
    @Published var selectedDepartment: String = "학과를 선택하세요"
}
