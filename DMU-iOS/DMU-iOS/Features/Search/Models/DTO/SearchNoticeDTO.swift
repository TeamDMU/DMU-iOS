//
//  SearchNoticeDTO.swift
//  DMU-iOS
//
//  Created by 이예빈 on 3/1/24.
//

import Foundation

struct SearchNoticeDTO: Decodable {
    let date: String
    let title: String
    let author: String
    let url: String
}

extension SearchNoticeDTO {
    func toSearchNotice() -> SearchNotice {
        let date = Date.dateFromFormattedString(date) ?? Date()
        
        return SearchNotice(noticeTitle: title, noticeDate: date, noticeStaffName: author, noticeURL: url)
    }
}
