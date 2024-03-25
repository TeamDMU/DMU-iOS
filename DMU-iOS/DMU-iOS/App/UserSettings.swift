//
//  UserSettings.swift
//  DMU-iOS
//
//  Created by 이예빈 on 1/5/24.
//

import Combine
import Foundation

class UserSettings: ObservableObject {
    
    @Published var selectedDepartment: String {
        didSet {
            UserDefaults.standard.set(selectedDepartment, forKey: "SelectedDepartment")
        }
    }
    
    @Published var selectedKeywordsContents: [String] {
        didSet {
            UserDefaults.standard.set(selectedKeywordsContents, forKey: "selectedKeywordsContents")
        }
    }
    
    @Published var fcmToken: String {
        didSet {
            UserDefaults.standard.set(fcmToken, forKey: "fcmToken")
        }
    }
    
    @Published var isDepartmentNotificationOn: Bool {
        didSet {
            UserDefaults.standard.set(isDepartmentNotificationOn, forKey: "isDepartmentNotificationOn")
        }
    }
    
    @Published var isKeywordNotificationOn: Bool {
        didSet {
            UserDefaults.standard.set(isKeywordNotificationOn, forKey: "isKeywordNotificationOn")
        }
    }
    
    init() {
        self.selectedDepartment = UserDefaults.standard.object(forKey: "SelectedDepartment") as? String ?? "학과를 선택하세요"
        self.selectedKeywordsContents = UserDefaults.standard.object(forKey: "selectedKeywordsContents") as? [String] ?? []
        self.fcmToken = UserDefaults.standard.object(forKey: "fcmToken") as? String ?? "토큰 없음"
        self.isDepartmentNotificationOn = UserDefaults.standard.object(forKey: "isDepartmentNotificationOn") as? Bool ?? false
        self.isKeywordNotificationOn = UserDefaults.standard.object(forKey: "isKeywordNotificationOn") as? Bool ?? false
    }
}
