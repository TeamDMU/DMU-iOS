//
//  DateFormatExtension.swift
//  DMU-iOS
//
//  Created by 이예빈 on 2/9/24.
//

import Foundation

extension DateFormatter {
    static let customFormat: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter
    }()
}

extension Date {
    var formattedString: String {
        return DateFormatter.customFormat.string(from: self)
    }

    static func dateFromFormattedString(_ dateString: String) -> Date? {
        return DateFormatter.customFormat.date(from: dateString)
    }
}
