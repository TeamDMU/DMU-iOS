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
    @Published var universityNotices: [UniversityNotice] = []
    @Published var departmentNotices: [DepartmentNotice] = []
    @Published var isShowingWebView = false
    
    
    // MARK: -학과별 필터링을 위한 UserSetting 초기화
    private var userSettings: UserSettings
    
    init(userSettings: UserSettings) {
        self.userSettings = userSettings
        loadUniversityNoticeData()
        loadDepartmentNoticeData(department: userSettings.selectedDepartment)
    }
    
    // MARK: - 대학공지 데이터 통신
    private let universitynoticeService = UniversityNoticeService()
    
    func loadUniversityNoticeData() {
        universitynoticeService.getUniversityNotices{ result in
            DispatchQueue.main.async {
                switch result {
                case .success(let notices):
                    self.universityNotices = notices
                    print(notices)
                case .failure(let error):
                    print("Failed to get university notices: \(error)")
                }
            }
        }
    }
    
    // MARK: - 학부공지 데이터 통신
    private let departmentNoticeService = DepartmentNoticeService()
    
    @Published var isLoading = false
    private var currentPage = 1
    private let itemsPerPage = 10
    
    func loadDepartmentNoticeData(department: String) {
        self.currentPage = 1
        self.departmentNotices = []
        loadMoreDepartmentNotices(department: department)
    }
    
    func loadMoreDepartmentNotices(department: String) {
        self.isLoading = true
        
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                self.departmentNoticeService.getDepartmentNotices(department: department, page: self.currentPage, size: self.itemsPerPage) { result in
                    switch result {
                    case .success(let notices):
                        self.departmentNotices.append(contentsOf: notices)
                    case .failure(let error):
                        print("Failed to get department notices: \(error.localizedDescription)")
                    }
                    
                    self.isLoading = false
                }
            }
        }
    }
    
    func loadMoreData() {
        if !isLoading {
            currentPage += 1
            loadMoreDepartmentNotices(department: userSettings.selectedDepartment)
        }
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
