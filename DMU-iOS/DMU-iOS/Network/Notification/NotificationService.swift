//
//  NotificationService.swift
//  DMU-iOS
//
//  Created by 이예빈 on 3/26/24.
//

import Foundation

class NotificationService {
    private let repository = NotificationRepository()

    func postUpdateKeyword(tokens: [String], topic: [String], completion: @escaping (Result<Bool, Error>) -> Void) {
        repository.postUpdateKeyword(tokens: tokens, topic: topic, completion: completion)
    }
    
    func postDeleteKeyword(tokens: [String], topic: [String], completion: @escaping (Result<Bool, Error>) -> Void) {
        repository.postDeleteKeyword(tokens: tokens, topic: topic, completion: completion)
    }
    
    func postUpdateDepartment(tokens: [String], department: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        repository.postUpdateDepartment(tokens: tokens, department: department, completion: completion)
    }
    
    func postDeleteDepartment(tokens: [String], department: String, completion: @escaping (Result<Bool, Error>) -> Void) {
        repository.postDeleteDepartment(tokens: tokens, department: department, completion: completion)
    }
}
