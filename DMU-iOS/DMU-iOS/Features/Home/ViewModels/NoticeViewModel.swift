//
//  NoticeViewModel.swift
//  DMU-iOS
//
//  Created by 이예빈 on 12/31/23.
//

import Foundation

class NoticeViewModel: ObservableObject {
    
    @Published var selectedTab: String = "대학공지"
    @Published var notices: [Notice] = sampleData
    
    // MARK: -학과별 필터링을 위한 UserSetting 초기화
    private var userSettings: UserSettings
    
    init(userSettings: UserSettings) {
        self.userSettings = userSettings
    }
    
    // MARK: -공지사항 날짜 데이터 포맷
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy.MM.dd"
        
        return formatter.string(from: date)
    }
    
    // MARK: -대학공지, 학부공지 별 탭 필터링
    func filteredNotices() -> [Notice] {
        return notices.filter { $0.noticeType == selectedTab }
    }
    
    // MARK: -학부공지 학과별 리스트 필터링
    func filteredNotices(department: String?) -> [Notice] {
        if selectedTab == "대학공지" {
            return notices.filter { $0.noticeType == "대학공지" }
        } else if selectedTab == "학부공지" {
            return notices.filter { notice in
                guard let department = department, !department.isEmpty else { return false }
                
                return notice.noticeType == "학부공지" && notice.noticeDepartment == department
            }
        }
        
        return notices
    }
    
    // MARK: -키워드 알림창 화면으로 이동
    
    @Published var isNavigationToNotification: Bool = false
    
    func navigateToNotification() {
        isNavigationToNotification = true
    }
}
