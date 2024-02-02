//
//  MenuDTO.swift
//  DMU-iOS
//
//  Created by 이예빈 on 2/2/24.
//

import Foundation

struct MenuDTO: Decodable {
    let date: String
    let menus: [String]
}

extension MenuDTO {
    func toMenus() -> Menu {
        return Menu(date: date, details: menus)
    }
}
