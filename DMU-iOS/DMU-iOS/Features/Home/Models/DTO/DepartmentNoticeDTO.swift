//
//  DepartmentNoticeDTO.swift
//  DMU-iOS
//
//  Created by 이예빈 on 2/29/24.
//

import Foundation

struct DepartmentNoticeDTO: Decodable {
    let date: String
    let title: String
    let author: String
    let url: String
}

extension DepartmentNoticeDTO {
    func toDepartmentNotice(department: String) -> DepartmentNotice {
        let date = Date.dateFromFormattedString(date) ?? Date()
        
        return DepartmentNotice(noticeTitle: title, noticeDate: date, noticeStaffName: author, noticeURL: url, noticeDepartment: department)
    }
}
