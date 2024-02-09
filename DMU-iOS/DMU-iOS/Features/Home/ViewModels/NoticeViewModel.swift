//
//  NoticeViewModel.swift
//  DMU-iOS
//
//  Created by 이예빈 on 12/31/23.
//

import Foundation

enum NoticeTab: String {
    case university = "대학 공지"
    case department = "학과 공지"
}

class NoticeViewModel: ObservableObject {
    
    @Published var selectedTab: NoticeTab = .university
    @Published var universityNotices: [UniversityNotice] = sampleUniversityNotices
    @Published var departmentNotices: [DepartmentNotice] = sampleDepartmentNotices
    @Published var isShowingWebView = false
    
    
    // MARK: -학과별 필터링을 위한 UserSetting 초기화
    private var userSettings: UserSettings
    
    init(userSettings: UserSettings) {
        self.userSettings = userSettings
    }
    
    // MARK: -학부공지 학과별 리스트 필터링
    func filterDepartmentNotices(department: String?) -> [DepartmentNotice] {
        return departmentNotices.filter { notice in
            guard let department = department, !department.isEmpty else { return false }
            
            return notice.noticeDepartment == department
        }
    }
    
    // MARK: -공지사항 화면 키워드 알림창 화면으로 이동
    
    @Published var isNavigationToNotification: Bool = false
    
    func navigateToNotification() {
        isNavigationToNotification = true
    }
}
