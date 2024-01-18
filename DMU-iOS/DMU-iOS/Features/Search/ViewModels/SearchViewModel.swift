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
    
    func clearText() {
        self.searchText = ""
        
        onSearchTextChange() // 검색어를 지웠을 때도 최근 검색어를 다시 불러옵니다.
    }
    
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy.MM.dd"
        
        return formatter.string(from: date)
    }
    
    // ViewModel이 초기화 될 때, UserDefaults에서 최근 검색어 불러오기
    init() {
        loadRecentSearches()
    }
    
    // UserDefaults에서 최근 검색어를 불러오는 메서드
    func loadRecentSearches() {
        if let searches = UserDefaults.standard.array(forKey: "recentSearches") as? [String] {
            self.recentSearches = searches
        }
    }
    
    // UserDefaults에 최근 검색어를 저장하는 메서드
    private func saveRecentSearches() {
        UserDefaults.standard.set(self.recentSearches, forKey: "recentSearches")
    }
    
    // 최근 검색어를 추가하는 메서드
    func addRecentSearch(_ search: String) {
        if !search.isEmpty && !self.recentSearches.contains(search) {
            self.recentSearches.append(search)
            // 배열 크기 제한 또는 오래된 검색어 제거 로직 추가 가능
            saveRecentSearches()
        }
    }
    
    // 최근 검색어를 삭제하는 메서드
    func removeRecentSearch(_ search: String) {
        self.recentSearches.removeAll { $0 == search }
        
        saveRecentSearches()
    }
    
    // 검색어가 변경될 때 호출되는 메서드
    func onSearchTextChange() {
        if searchText.isEmpty {
            loadRecentSearches()
        } else {
            recentSearches = []
        }
    }
    
    // 검색을 수행할 때 호출되는 메서드
    func performSearch() {
        if !searchText.isEmpty {
            addRecentSearch(searchText)
        }
    }
    
    // 모든 결과 보기 버튼을 눌렀을 때 검색 수행
    func showAllResults() {
        performSearch()
    }
    
    // 검색 뷰로 돌아왔을 때 호출될 초기화 메서드
    func resetSearchState() {
        searchText = ""
        isEditing = false
        isNavigating = false
        
        loadRecentSearches() // 최근 검색어를 다시 불러옵니다.
    }
}


