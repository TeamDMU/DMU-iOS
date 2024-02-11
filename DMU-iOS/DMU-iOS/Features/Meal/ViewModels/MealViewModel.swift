//
//  MealViewModel.swift
//  DMU-iOS
//
//  Created by 이예빈 on 1/4/24.
//

import Foundation

class MealViewModel: ObservableObject {
    
    @Published var menus = sampleMenu
    
    // MARK: 첫 번째 요일(월요일) 날짜 변환 -> 월요일을 주의 첫 번째 날로 설정
    func startOfWeek(date: Date) -> Date {
        
        var calendar = Calendar(identifier: .gregorian)
        
        calendar.firstWeekday = 2
        
        return calendar.date(from: calendar.dateComponents([.yearForWeekOfYear, .weekOfYear], from: date))!
    }
    
    // MARK: 현재 날짜가 주말(토요일 또는 일요일)인지 여부 반환
    func isWeekend(_ date: Date) -> Bool {
        
        let calendar = Calendar.current
        let weekday = calendar.component(.weekday, from: date)
        
        return weekday == 7 || weekday == 1
    }
    
    // MARK: 주어진 날짜에 해당하는 메뉴를 반환
    func getMenuForDate(for date: Date) -> Menu? {
        
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy-MM-dd"
        
        let dateString = formatter.string(from: date)
        
        return menus.first(where: { $0.date == dateString })
    }
}
