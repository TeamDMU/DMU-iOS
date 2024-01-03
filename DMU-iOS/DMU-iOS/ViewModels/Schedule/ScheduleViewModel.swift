//
//  ScheduleViewModel.swift
//  DMU-iOS
//
//  Created by 이예빈 on 1/3/24.
//

import Foundation

class ScheduleViewModel: ObservableObject {
    @Published var currentDate = Date()
    @Published var schedules: [Schedule] = []
    
    private let calendar = Calendar.current

    init() {
        refreshData()
    }
    
    func refreshData() {
        schedules = fetchSchedulesForCurrentMonth()
    }
    
    func changeMonth(by increment: Int) {
        guard let newDate = calendar.date(byAdding: .month, value: increment, to: currentDate) else { return }
        currentDate = newDate
        refreshData()
    }
    
    var currentYearMonth: String {
        formatDateToYearMonth(currentDate)
    }
    
    // MARK: - Helper Methods
    
    private func makeDate(year: Int, month: Int, day: Int) -> Date {
        DateComponents(calendar: calendar, year: year, month: month, day: day).date ?? Date()
    }
    
    private func fetchSchedulesForCurrentMonth() -> [Schedule] {
        let allSchedules = [
            Schedule(date: makeDate(year: 2024, month: 1, day: 10), detail: "신입생 오리엔테이션 및 어쩌구 저쩌구"),
            Schedule(date: makeDate(year: 2024, month: 1, day: 11), detail: "졸업식"),
            Schedule(date: makeDate(year: 2024, month: 2, day: 14), detail: "중간고사 시작"),
            Schedule(date: makeDate(year: 2024, month: 3, day: 21), detail: "스프링 브레이크")
        ]
        
        return allSchedules.filter { calendar.isDate($0.date, equalTo: currentDate, toGranularity: .month) }
    }
    
    private func formatDateToYearMonth(_ date: Date) -> String {
        let year = calendar.component(.year, from: date)
        let month = calendar.component(.month, from: date)
        return "\(year)년 \(month)월"
    }
}
