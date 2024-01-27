//
//  ScheduleResult.swift
//  DMU-iOS
//
//  Created by 이예빈 on 1/26/24.
//

import Foundation

struct ScheduleResult: Decodable {
    let schedules: [YearSchedule]
}

struct YearSchedule: Decodable {
    let year: Int
    let yearSchedule: [MonthSchedule]
}

struct MonthSchedule: Decodable {
    let month: Int
    let scheduleEntries: [ScheduleEntry]
}

struct ScheduleEntry: Decodable {
    let date: [String]
    let content: String
}

extension ScheduleResult {
    func toSchedules() -> [Schedule] {
        return schedules.flatMap { yearSchedule in
            yearSchedule.yearSchedule.flatMap { monthSchedule in
                monthSchedule.scheduleEntries.map { scheduleEntry in
                    Schedule(year: yearSchedule.year,
                             month: monthSchedule.month,
                             startDate: scheduleEntry.date.first ?? "",
                             endDate: scheduleEntry.date.last ?? "",
                             detail: scheduleEntry.content)
                }
            }
        }
    }
}
