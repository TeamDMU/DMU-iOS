//
//  SearchNoticeService.swift
//  DMU-iOS
//
//  Created by 이예빈 on 3/1/24.
//

import Foundation

class SearchNoticeService {
    private let repository = SearchNoticeRepository()

    func getSearchNotices(searchWord: String, department: String, page: Int, size: Int, completion: @escaping (Result<[SearchNotice], Error>) -> Void) {
        repository.getSearchNotices(searchWord: searchWord, department: department, page: page, size: size, completion: completion)
    }
}
