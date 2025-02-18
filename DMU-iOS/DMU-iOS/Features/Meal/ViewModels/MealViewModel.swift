//
//  MealViewModel.swift
//  DMU-iOS
//
//  Created by 이예빈 on 1/4/24.
//

import Foundation

class MealViewModel: ObservableObject {
    
    @Published var weeklyMenu: [Menu] = []
    @Published var weeklyOneMenu: [OneMenu] = OneMenuList
    @Published var isMenuLoading = false
    @Published var isMenuLoadingFailed = false
    
    private let menuService = MenuService()
    
    private var calendar: Calendar = {
        var cal = Calendar(identifier: .gregorian)
        cal.firstWeekday = 2 // 월요일을 주의 첫번째 날로 설정
        return cal
    }()
    
    private var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    // MARK: 금주의 식단 데이터 통신
    func loadMenuData() {
        self.isMenuLoading = true
        self.isMenuLoadingFailed = false
        
        menuService.getMenus { [weak self] result in
            DispatchQueue.main.async {
                self?.isMenuLoading = false
                switch result {
                case .success(let menus):
                    self?.weeklyMenu = menus
                    self?.isMenuLoadingFailed = false
                case .failure(let error):
                    print("Failed to get menus: \(error)")
                    self?.isMenuLoadingFailed = true
                }
            }
        }
    }
    
    // MARK: 첫 번째 요일(월요일) 날짜 변환
    func startOfWeek(date: Date) -> Date {
        let components = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date)
        return calendar.date(from: components) ?? date
    }
    
    // MARK: 현재 날짜가 주말(토요일 또는 일요일)인지 여부 반환
    func isWeekend(_ date: Date) -> Bool {
        let weekday = calendar.component(.weekday, from: date)
        return Set([1, 7]).contains(weekday) // 1: 토요일, 7: 일요일
    }
    
    // MARK: 주어진 날짜에 해당하는 메뉴를 반환
    func getMenuForDate(for date: Date) -> Menu? {
        let dateString = dateFormatter.string(from: date)
        return weeklyMenu.first(where: { $0.date == dateString })
    }
    
    // MARK: - 요일별 일품 메뉴 필터링
    func filteredOneMenu(for date: Date) -> [OneMenu] {
        let weekday = calendar.component(.weekday, from: date)
        let selectedWeekday: Weekday
        
        switch weekday {
        case 2: selectedWeekday = .monday
        case 3: selectedWeekday = .tuesday
        case 4: selectedWeekday = .wednesday
        case 5: selectedWeekday = .thursday
        case 6: selectedWeekday = .friday
        default: return [] // 월요일에서 금요일, 외의 요일은 처리하지 않음
        }
        
        return weeklyOneMenu.filter { $0.availableDays.contains(selectedWeekday) }
    }
}
