//
//  UniversityNoticeService.swift
//  DMU-iOS
//
//  Created by 이예빈 on 2/19/24.
//

import Foundation

class UniversityNoticeService {
    private let repository = UniversityNoticeRepository()

    func getUniversityNotices(page: Int, size: Int, completion: @escaping (Result<[UniversityNotice], Error>) -> Void) {
        repository.getUniversityNotices(page: page, size: size, completion: completion)
    }
}
