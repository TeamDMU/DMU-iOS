//
//  DepartmentNoticeService.swift
//  DMU-iOS
//
//  Created by 이예빈 on 2/29/24.
//

import Foundation

class DepartmentNoticeService {
    private let repository = DepartmentNoticeRepository()
    
    func getDepartmentNotices(department: String, completion: @escaping (Result<[DepartmentNotice], Error>) -> Void) {
        repository.getDepartmentNotices(department: department, completion: completion)
    }
}
