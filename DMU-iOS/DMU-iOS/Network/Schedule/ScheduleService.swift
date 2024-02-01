//
//  ScheduleService.swift
//  DMU-iOS
//
//  Created by 이예빈 on 1/26/24.
//

import Foundation

class ScheduleService {
    private let repository = ScheduleRepository()

    func getSchedules(year: Int, month: Int, completion: @escaping (Result<[Schedule], Error>) -> Void) {
        repository.getSchedules(year: year, month: month, completion: completion)
    }
}
