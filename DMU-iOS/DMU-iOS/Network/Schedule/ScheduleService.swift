//
//  ScheduleService.swift
//  DMU-iOS
//
//  Created by 이예빈 on 1/26/24.
//

import Foundation

import Moya

class ScheduleService: Networking {
    let provider = MoyaProvider<APIService>()

    func getSchedules(year: Int, month: Int, completion: @escaping (Result<[Schedule], Error>) -> Void) {
        request(.getSchedules(year: year, month: month)) { result in
            switch result {
            case .success(let response):
                do {
                    let scheduleResult = try JSONDecoder().decode(ScheduleResult.self, from: response.data)
                    let schedules = scheduleResult.toSchedules()
                    print("Received schedules")
                    completion(.success(schedules))
                } catch let error {
                    print("Decoding failed with error: \(error)")
                    completion(.failure(error))
                }
            case .failure(let error):
                print("Network request failed with error: \(error)")
                completion(.failure(error))
            }
        }
    }
}
