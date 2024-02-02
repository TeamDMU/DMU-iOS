//
//  MenuRepository.swift
//  DMU-iOS
//
//  Created by 이예빈 on 2/2/24.
//

import Foundation

import Moya

class MenuRepository {
    let provider = MoyaProvider<APIService>()

    func getMenus(completion: @escaping (Result<[Menu], Error>) -> Void) {
        provider.request(.getMenus) { result in
            switch result {
            case .success(let response):
                do {
                    let menuDTOs = try JSONDecoder().decode([MenuDTO].self, from: response.data)
                    let menus = menuDTOs.compactMap { $0.toMenus() }
                    completion(.success(menus))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
