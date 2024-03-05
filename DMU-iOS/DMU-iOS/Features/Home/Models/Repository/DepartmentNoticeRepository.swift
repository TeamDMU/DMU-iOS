//
//  DepartmentNoticeRepository.swift
//  DMU-iOS
//
//  Created by 이예빈 on 2/29/24.
//

import Foundation

import Moya

class DepartmentNoticeRepository {
    let provider = MoyaProvider<APIService>()
    
    func getDepartmentNotices(department: String, page: Int, size: Int, completion: @escaping (Result<[DepartmentNotice], Error>) -> Void) {
        provider.request(.getDepartmentNotices(department: department, page: page, size: size)) { result in
            switch result {
            case .success(let response):
                do {
                    let noticeDTOs = try JSONDecoder().decode([DepartmentNoticeDTO].self, from: response.data)
                    let notices = noticeDTOs.map { $0.toDepartmentNotice(department: department) }
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
