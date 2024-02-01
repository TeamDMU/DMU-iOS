//
//  ScheduleResult.swift
//  DMU-iOS
//
//  Created by 이예빈 on 1/26/24.
//

import Foundation

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

extension YearSchedule {
    func toSchedules() -> [Schedule] {
        return yearSchedule.flatMap { monthSchedule in
            monthSchedule.scheduleEntries.map { scheduleEntry in
                Schedule(year: year,
                         month: monthSchedule.month,
                         startDate: scheduleEntry.date.first ?? "",
                         endDate: scheduleEntry.date.last ?? "",
                         detail: scheduleEntry.content)
            }
        }
    }
}
