//
//  MealViewModel.swift
//  DMU-iOS
//
//  Created by 이예빈 on 1/4/24.
//

import Foundation

class MealViewModel: ObservableObject {
    
    @Published var weeklyMenu: [Menu] = []
    
    private let calendar = Calendar.current
    private let dateFormatterGet = DateFormatter()
    private let dateFormatterPrint = DateFormatter()
    
    private let menuService = MenuService()
    
    init() {
        dateFormatterGet.dateFormat = "yyyy.MM.dd"
        dateFormatterPrint.dateFormat = "yyyy년 MM월 dd일"
        loadData()
    }
    
    func loadData() {
            menuService.getMenus { [weak self] result in
                switch result {
                case .success(let menus):
                    DispatchQueue.main.async {
                        self?.weeklyMenu = menus
                    }
                case .failure(let error):
                    print("Failed to get menus: \(error)")
                }
            }
        }
    
    // MARK: 금주의 식단 화면 날짜 데이터 포맷
    func formatDate(_ dateString: String) -> String {
        if let date = dateFormatterGet.date(from: dateString) {
            return dateFormatterPrint.string(from: date)
        } else {
            return dateString
        }
    }
    
    // MARK: 현재 날짜 기준 해당 주차 설정
    func isDateInThisWeek(_ date: Date) -> Bool {
        guard let startOfWeek = calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date())),
              let endOfWeek = calendar.date(byAdding: .day, value: 6, to: startOfWeek) else {
            return false
        }
        
        return date >= startOfWeek && date <= endOfWeek
    }
    
    // MARK: 한 주의 시작 날짜
    var startOfWeek: Date {
        calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: Date()))!
    }
    
    // MARK: 한 주의 끝 날짜
    var endOfWeek: Date {
        calendar.date(byAdding: .day, value: 6, to: startOfWeek)!
    }
    
    // MARK: 금주의 식단 메뉴 필터링
    var thisWeeksMenu: [Menu] {
        weeklyMenu.filter { menu in
            if let date = dateFormatterGet.date(from: menu.date) {
                return isDateInThisWeek(date)
            }
            
            return false
        }
    }
}
