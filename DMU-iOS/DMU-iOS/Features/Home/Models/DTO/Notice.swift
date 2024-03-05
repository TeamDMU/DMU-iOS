//
//  Notice.swift
//  DMU-iOS
//
//  Created by 이예빈 on 12/31/23.
//

import Foundation

protocol NoticeProtocol: Identifiable {
    var noticeTitle: String { get }
    var noticeDate: Date { get }
    var noticeStaffName: String { get }
    var noticeURL: String { get }
}

// MARK: -추후 api 통신 연결할 때 수정할 예정

struct UniversityNotice: NoticeProtocol {
    var id = UUID()
    var noticeTitle: String
    var noticeDate: Date
    var noticeStaffName : String
    var noticeURL : String
}

struct DepartmentNotice: NoticeProtocol, Equatable {
    var id = UUID()
    var noticeTitle: String
    var noticeDate: Date
    var noticeStaffName : String
    var noticeURL : String
    var noticeDepartment: String
    
    static func ==(lhs: DepartmentNotice, rhs: DepartmentNotice) -> Bool {
        return lhs.id == rhs.id
    }
}
