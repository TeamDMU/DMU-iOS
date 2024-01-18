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
    
    init() {
        dateFormatterGet.dateFormat = "yyyy.MM.dd"
        dateFormatterPrint.dateFormat = "yyyy년 MM월 dd일"
    }
    
    // MARK: 예시 데이터를 불러오는 함수
    func loadSampleData() {
        let sampleData = [
            Menu(date: "2024.01.02", details: ["백미밥", "아귀콩나물찜", "동그랑땡전", "청포묵김무침", "배추김치", "소고기미역국"]),
            Menu(date: "2024.01.03", details: ["백미밥", "아귀콩나물찜", "동그랑땡전", "청포묵김무침", "배추김치", "소고기미역국"]),
            Menu(date: "2024.01.04", details: ["백미밥", "아귀콩나물찜", "동그랑땡전", "청포묵김무침", "배추김치", "소고기미역국"]),
            Menu(date: "2024.01.05", details: ["백미밥", "아귀콩나물찜", "동그랑땡전", "청포묵김무침", "배추김치", "소고기미역국"]),
            Menu(date: "2024.01.08", details: ["백미밥", "아귀콩나물찜", "동그랑땡전", "청포묵김무침", "배추김치", "소고기미역국"]),
            Menu(date: "2024.01.09", details: ["백미밥", "아귀콩나물찜", "동그랑땡전", "청포묵김무침", "배추김치", "소고기미역국"]),
            Menu(date: "2024.01.10", details: ["백미밥", "아귀콩나물찜", "동그랑땡전", "청포묵김무침", "배추김치", "소고기미역국"]),
            Menu(date: "2024.01.11", details: ["백미밥", "아귀콩나물찜", "동그랑땡전", "청포묵김무침", "배추김치", "소고기미역국"]),
        ]
        weeklyMenu = sampleData
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
