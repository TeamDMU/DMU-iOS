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
    @Published var universityNotices: [UniversityNotice] = []
    @Published var departmentNotices: [DepartmentNotice] = []
    
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
            DispatchQueue.global(qos: .userInitiated).async { [weak self] in
                guard let self = self else { return }
                
                DispatchQueue.main.async {
                    self.searchedText = self.searchText
                }
            }
        }
    }
    
    var shouldShowResults: Bool {
        return !searchedText.isEmpty
    }
    
    // MARK: 검색 필터링
    var filteredUniversityNotices: [UniversityNotice] {
        return universityNotices.filter { notice in
            searchedText.isEmpty ||
            notice.noticeTitle.lowercased().contains(searchedText.lowercased())
        }
    }
    
    var filteredDepartmentNotices: [DepartmentNotice] {
        return departmentNotices.filter { notice in
            searchedText.isEmpty ||
            notice.noticeTitle.lowercased().contains(searchedText.lowercased())
        }
    }
}
