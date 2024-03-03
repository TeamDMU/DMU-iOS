//
//  SearchNoticeRepository.swift
//  DMU-iOS
//
//  Created by 이예빈 on 3/1/24.
//

import Foundation

import Moya

class SearchNoticeRepository {
    let provider = MoyaProvider<APIService>()
    
    func getSearchNotices(searchWord: String, page: Int = 1, size: Int = 20, completion: @escaping (Result<[SearchNotice], Error>) -> Void) {
        provider.request(.getSearchNotices(searchWord: searchWord, page: page, size: size)) { result in
            switch result {
            case .success(let response):
                do {
                    let noticeDTOs = try JSONDecoder().decode([SearchNoticeDTO].self, from: response.data)
                    let notices = noticeDTOs.map { $0.toSearchNotice() }
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

