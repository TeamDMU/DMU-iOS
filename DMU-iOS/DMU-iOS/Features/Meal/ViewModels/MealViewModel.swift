//
//  MealViewModel.swift
//  DMU-iOS
//
//  Created by 이예빈 on 1/4/24.
//

import Foundation

class MealViewModel: ObservableObject {
    
    @Published var menus = sampleMenu
    
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
    
    // MARK: 첫 번째 요일(월요일) 날짜 변환
    func startOfWeek(date: Date) -> Date {
        let components = calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date)
        let startOfWeek = calendar.date(from: components)!
        
        return startOfWeek
    }
    
    // MARK: 현재 날짜가 주말(토요일 또는 일요일)인지 여부 반환
    func isWeekend(_ date: Date) -> Bool {
        let weekday = calendar.component(.weekday, from: date)
        let isWeekend = (weekday == 7 || weekday == 1)
        
        return isWeekend
    }
    
    // MARK: 주어진 날짜에 해당하는 메뉴를 반환
    func getMenuForDate(for date: Date) -> Menu? {
        let dateString = dateFormatter.string(from: date)
        let menuForDate = menus.first(where: { $0.date == dateString })
        
        return menuForDate
    }
}
