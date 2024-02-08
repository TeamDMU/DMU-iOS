//
//  SearchViewModel.swift
//  DMU-iOS
//
//  Created by 이예빈 on 1/1/24.
//

import Foundation

class SearchViewModel: ObservableObject {
    
    @Published var searchText = ""
    @Published var isEditing = false
    @Published var isNavigating: Bool = false
    @Published var recentSearches: [String] = []
    @Published var universityNotices: [UniversityNotice] = sampleUniversityNotices
    @Published var departmentNotices: [DepartmentNotice] = sampleDepartmentNotices
    
    func clearText() {
        self.searchText = ""
        
        onSearchTextChange()
    }
    
    // MARK: 검색 화면 날짜 데이터 포맷
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy.MM.dd"
        
        return formatter.string(from: date)
    }
    
    // MARK: ViewModel이 초기화 될 때, UserDefaults에서 최근 검색어 불러오기
    init() {
        loadRecentSearches()
    }
    
    // MARK: UserDefaults에서 최근 검색어 데이터 불러오는 메서드
    func loadRecentSearches() {
        if let searches = UserDefaults.standard.array(forKey: "recentSearches") as? [String] {
            self.recentSearches = searches
        }
    }
    
    // MARK: UserDefaults에 최근 검색어 데이터를 저장하는 메서드
    private func saveRecentSearches() {
        UserDefaults.standard.set(self.recentSearches, forKey: "recentSearches")
    }
    
    // MARK: 최근 검색어를 추가하는 메서드
    func addRecentSearch(_ search: String) {
        if !search.isEmpty && !self.recentSearches.contains(search) {
            self.recentSearches.append(search)
            // 배열 크기 제한 또는 오래된 검색어 제거 로직 추가 가능
            saveRecentSearches()
        }
    }
    
    // MARK: 최근 검색어를 삭제하는 메서드
    func removeRecentSearch(_ search: String) {
        self.recentSearches.removeAll { $0 == search }
        
        saveRecentSearches()
    }
    
    // MARK: 검색어가 변경될 때 호출되는 메서드
    func onSearchTextChange() {
        if searchText.isEmpty {
            loadRecentSearches()
        } else {
            recentSearches = []
        }
    }
    
    // MARK: 검색을 수행할 때 호출되는 메서드
    func performSearch() {
        if !searchText.isEmpty {
            addRecentSearch(searchText)
        }
    }
}


