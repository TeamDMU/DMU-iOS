//
//  MenuService.swift
//  DMU-iOS
//
//  Created by 이예빈 on 2/2/24.
//

import Foundation

class MenuService {
    private let repository = MenuRepository()

    func getMenus(completion: @escaping (Result<[Menu], Error>) -> Void) {
        repository.getMenus(completion: completion)
    }
}
