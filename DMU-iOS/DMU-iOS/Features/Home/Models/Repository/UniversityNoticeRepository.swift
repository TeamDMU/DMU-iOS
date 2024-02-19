//
//  UniversityNoticeRepository.swift
//  DMU-iOS
//
//  Created by 이예빈 on 2/19/24.
//

import Foundation

import Moya

class UniversityNoticeRepository {
    let provider = MoyaProvider<APIService>()
    
    func getUniversityNotices(completion: @escaping (Result<[UniversityNotice], Error>) -> Void) {
        provider.request(.getUniversityNotices) { result in
            switch result {
            case .success(let response):
                do {
                    let noticeDTOs = try JSONDecoder().decode([UniversityNoticeDTO].self, from: response.data)
                    let notices = noticeDTOs.map { $0.toUniversityNotice() }
                    completion(.success(notices))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
