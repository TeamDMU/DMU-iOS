//
//  UniversityNoticeDTO.swift
//  DMU-iOS
//
//  Created by 이예빈 on 2/19/24.
//

import Foundation

struct UniversityNoticeDTO: Decodable {
    let date: String
    let title: String
    let author: String
    let url: String
}

extension UniversityNoticeDTO {
    func toUniversityNotice() -> UniversityNotice {
        let date = Date.dateFromFormattedString(date) ?? Date()
        
        return UniversityNotice(noticeTitle: title, noticeDate: date, noticeStaffName: author, noticeURL: url)
    }
}
