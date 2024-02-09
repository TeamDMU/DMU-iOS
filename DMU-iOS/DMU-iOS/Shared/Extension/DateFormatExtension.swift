//
//  DateFormatExtension.swift
//  DMU-iOS
//
//  Created by 이예빈 on 2/9/24.
//

import Foundation

extension Date {
    var formatDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter.string(from: self)
    }
}
