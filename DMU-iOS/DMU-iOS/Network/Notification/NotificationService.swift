//
//  NotificationService.swift
//  DMU-iOS
//
//  Created by 이예빈 on 3/26/24.
//

import Foundation

class NotificationService {
    private let repository = NotificationRepository()

    func postInitToken(token: String, department: String, topics: [String], completion: @escaping (Result<Bool, Error>) -> Void) {
        repository.postInitToken(token: token, department: department, topics: topics, completion: completion)
    }
    
    func postUpdateKeyword(token: String, topics: [String], completion: @escaping (Result<Bool, Error>) -> Void) {
        repository.postUpdateKeyword(token: token, topics: topics, completion: completion)
    }
    
    func postDeleteKeyword(token: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        repository.postDeleteKeyword(token: token, completion: completion)
    }
    
    func postUpdateDepartment(token: String, department: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        repository.postUpdateDepartment(token: token, department: department, completion: completion)
    }
    
    func postDeleteDepartment(token: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        repository.postDeleteDepartment(token: token, completion: completion)
    }
}
