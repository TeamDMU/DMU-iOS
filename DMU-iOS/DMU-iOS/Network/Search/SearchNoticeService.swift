//
//  SearchNoticeService.swift
//  DMU-iOS
//
//  Created by 이예빈 on 3/1/24.
//

import Foundation

class SearchNoticeService {
    private let repository = SearchNoticeRepository()

    func getSearchNotices(searchWord: String, completion: @escaping (Result<[SearchNotice], Error>) -> Void) {
        repository.getSearchNotices(searchWord: searchWord, completion: completion)
    }
}
