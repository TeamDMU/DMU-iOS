//
//  Schedule.swift
//  DMU-iOS
//
//  Created by 이예빈 on 1/3/24.
//

import Foundation

struct Schedule: Identifiable {
    let id = UUID()
    let year: Int
    let month: Int
    let startDate: String
    let endDate: String
    let detail: String
    
    private var isEqualDayEvent: Bool {
        startDate == endDate
    }
    
    var scheduleDisplay: String {
        if isEqualDayEvent {
            return "\(startDate)"
        } else {
            return "\(startDate) ~ \(endDate)"
        }
    }
}
