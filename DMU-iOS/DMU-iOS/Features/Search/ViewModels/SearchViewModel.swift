//
//  SearchViewModel.swift
//  DMU-iOS
//
//  Created by 이예빈 on 1/1/24.
//

import Foundation

class SearchViewModel: ObservableObject {
    
    @Published var searchText = "" {
        didSet {
            if searchText.isEmpty {
                searchedText = ""
            }
        }
    }
    
    @Published var searchedText = ""
    @Published var isEditing = false
    @Published var isNavigating: Bool = false
    @Published var universityNotices: [UniversityNotice] = sampleUniversityNotices
    @Published var departmentNotices: [DepartmentNotice] = sampleDepartmentNotices
    
    
    
    // MARK: 검색 화면 날짜 데이터 포맷
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy.MM.dd"
        
        return formatter.string(from: date)
    }
    
    // MARK: 검색 필드 편집을 시작하는 메서드
    func startSearchEditing() {
        isEditing = true
    }
    
    // MARK: 검색 필드 편집을 종료하는 메서드
    func endSearchEditing() {
        isEditing = false
    }
    
    // MARK: 검색어 삭제 메서드
    func clearText() {
        self.searchText = ""
    }
    
    // MARK: 검색 기능 수행 시 호출하는 메서드
    func performSearch() {
        if !searchText.isEmpty {
            self.searchedText = self.searchText
        }
    }
    
    var shouldShowResults: Bool {
        return !searchedText.isEmpty
    }
    
    // MARK: 검색 필터링
    var filteredUniversityNotices: [UniversityNotice] {
        return universityNotices.filter { notice in
            searchedText.isEmpty ||
            notice.notice.noticeTitle.lowercased().contains(searchedText.lowercased())
        }
    }
    
    var filteredDepartmentNotices: [DepartmentNotice] {
        return departmentNotices.filter { notice in
            searchedText.isEmpty ||
            notice.notice.noticeTitle.lowercased().contains(searchedText.lowercased())
        }
    }
}
