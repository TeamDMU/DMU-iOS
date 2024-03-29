//
//  Menu.swift
//  DMU-iOS
//
//  Created by 이예빈 on 1/4/24.
//

import Foundation

// MARK: - 한식
struct Menu: Identifiable {
    
    var id = UUID()
    var date: String
    var details: [String]
}
