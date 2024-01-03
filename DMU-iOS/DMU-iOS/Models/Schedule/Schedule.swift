//
//  Schedule.swift
//  DMU-iOS
//
//  Created by 이예빈 on 1/3/24.
//

import Foundation

struct AcademicSchedule: Identifiable {
    let id = UUID()
    let date: Date
    let detail: String
    
    // 날짜를 원하는 문자열 형식으로 변환하는 함수
    var dateString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM.dd" // 월과 일
        return formatter.string(from: date)
    }
    
    var dayString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E" // 요일
        return formatter.string(from: date)
    }
    
    // 날짜와 요일을 결합한 문자열
    var dateDisplay: String {
        "\(dateString)(\(dayString))"
    }
}
