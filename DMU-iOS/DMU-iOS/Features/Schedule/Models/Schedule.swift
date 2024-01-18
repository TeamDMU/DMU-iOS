//
//  Schedule.swift
//  DMU-iOS
//
//  Created by 이예빈 on 1/3/24.
//

import Foundation

struct Schedule: Identifiable {
    let id = UUID()
    let startDate: Date
    let endDate: Date
    let detail: String
    
    // MARK: 날짜를 원하는 문자열 형식으로 변환하는 함수
    private func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "MM.dd"
        
        return formatter.string(from: date)
    }
    
    // MARK: 요일을 반환하는 함수
    private func formatDay(_ date: Date) -> String {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "E" // 요일
        
        return formatter.string(from: date)
    }
    
    // MARK: 시작과 종료 날짜가 같은지 확인하는 함수
    private var isEqualDayEvent: Bool {
        Calendar.current.isDate(startDate, inSameDayAs: endDate)
    }
    
    // MARK: 일정을 보여주는 문자열
    var scheduleDisplay: String {
        if isEqualDayEvent {
            // 시작일과 종료일이 같다면 시작일만 표시
            return "\(formatDate(startDate))(\(formatDay(startDate)))"
        } else {
            // 시작일과 종료일이 다르다면 시작일과 종료일 모두 표시
            return "\(formatDate(startDate))(\(formatDay(startDate))) ~ \(formatDate(endDate))(\(formatDay(endDate)))"
        }
    }
}

