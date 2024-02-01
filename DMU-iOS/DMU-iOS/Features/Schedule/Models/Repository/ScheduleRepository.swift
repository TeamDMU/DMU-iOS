//
//  ScheduleRepository.swift
//  DMU-iOS
//
//  Created by 이예빈 on 2/1/24.
//

import Foundation

import Moya

class ScheduleRepository {
    let provider = MoyaProvider<APIService>()

    func getSchedules(year: Int, month: Int, completion: @escaping (Result<[Schedule], Error>) -> Void) {
        provider.request(.getSchedules(year: year, month: month)) { result in
            switch result {
            case .success(let response):
                do {
                    let scheduleDTOs = try JSONDecoder().decode([YearScheduleDTO].self, from: response.data)
                    let schedules = scheduleDTOs.flatMap { $0.toSchedules() }
                    completion(.success(schedules))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
