//
//  ScheduleDTO.swift
//  DMU-iOS
//
//  Created by 이예빈 on 2/1/24.
//

import Foundation

struct YearScheduleDTO: Decodable {
    let year: Int
    let yearSchedule: [MonthScheduleDTO]
}

struct MonthScheduleDTO: Decodable {
    let month: Int
    let scheduleEntries: [ScheduleEntryDTO]
}

struct ScheduleEntryDTO: Decodable {
    let date: [String]
    let content: String
}

extension YearScheduleDTO {
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
