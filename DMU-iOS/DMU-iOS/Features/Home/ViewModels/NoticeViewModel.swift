//
//  NoticeViewModel.swift
//  DMU-iOS
//
//  Created by 이예빈 on 12/31/23.
//

import Foundation

class NoticeViewModel: ObservableObject {
    
    @Published var selectedTab: String = "대학 공지"
    @Published var universityNotices: [UniversityNotice] = sampleUniversityNotices
    @Published var departmentNotices: [DepartmentNotice] = sampleDepartmentNotices
    @Published var isShowingWebView = false
    
    
    // MARK: -학과별 필터링을 위한 UserSetting 초기화
    private var userSettings: UserSettings
    
    init(userSettings: UserSettings) {
        self.userSettings = userSettings
    }
    
    // MARK: -공지사항 화면 날짜 데이터 포맷
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy.MM.dd"
        
        return formatter.string(from: date)
    }
    
    // MARK: -대학공지 필터링
    func filterUniversityNotices() -> [UniversityNotice] {
        return universityNotices
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
