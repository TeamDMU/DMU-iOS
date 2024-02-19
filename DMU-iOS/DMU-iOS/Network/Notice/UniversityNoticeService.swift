//
//  UniversityNoticeService.swift
//  DMU-iOS
//
//  Created by 이예빈 on 2/19/24.
//

import Foundation

class UniversityNoticeService {
    private let repository = UniversityNoticeRepository()

    func getUniversityNotices(completion: @escaping (Result<[UniversityNotice], Error>) -> Void) {
        repository.getUniversityNotices(completion: completion)
    }
}
