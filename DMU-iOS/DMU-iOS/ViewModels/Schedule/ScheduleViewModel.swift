//
//  ScheduleViewModel.swift
//  DMU-iOS
//
//  Created by 이예빈 on 1/3/24.
//

import Foundation

class AcademicCalendarViewModel: ObservableObject {
    @Published var currentDate = Date()
    @Published var schedules: [AcademicSchedule] = []
    
    let calendar = Calendar.current
    
    init() {
        // 임시 데이터 삽입
        refreshData()
    }
    
    private func makeDate(year: Int, month: Int, day: Int) -> Date {
        var dateComponents = DateComponents()
        dateComponents.year = year
        dateComponents.month = month
        dateComponents.day = day
        return calendar.date(from: dateComponents) ?? Date()
    }
    
    
    func refreshData() {
        let allSchedules = [
            AcademicSchedule(date: makeDate(year: 2024, month: 1, day: 10), detail: "신입생 오리엔테이션 및 어쩌구 저쩌구 어쩌구 저쩌구"),
            AcademicSchedule(date: makeDate(year: 2024, month: 1, day: 11), detail: "졸업식"),
            AcademicSchedule(date: makeDate(year: 2024, month: 2, day: 14), detail: "중간고사 시작"),
            AcademicSchedule(date: makeDate(year: 2024, month: 3, day: 21), detail: "스프링 브레이크")
        ]
        
        let year = calendar.component(.year, from: currentDate)
        let month = calendar.component(.month, from: currentDate)
        
        // 현재 선택된 년월과 일치하는 일정만 필터링합니다.
        schedules = allSchedules.filter { schedule in
            let scheduleYear = calendar.component(.year, from: schedule.date)
            let scheduleMonth = calendar.component(.month, from: schedule.date)
            return scheduleYear == year && scheduleMonth == month
        }
    }
    
    func changeMonth(by increment: Int) {
        if let newDate = calendar.date(byAdding: .month, value: increment, to: currentDate) {
            currentDate = newDate
            refreshData()
        }
    }
    
    
    var currentYearMonth: String {
        let year = calendar.component(.year, from: currentDate)
        let month = calendar.component(.month, from: currentDate)
        return "\(year)년 \(month)월"
    }
}
