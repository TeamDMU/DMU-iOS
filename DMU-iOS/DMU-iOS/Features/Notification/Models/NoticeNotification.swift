//
//  NoticeNotification.swift
//  DMU-iOS
//
//  Created by 이예빈 on 2/7/24.
//

import Foundation

struct NoticeNotification: Identifiable {
    var id = UUID()
    var noticeTitle: String
    var noticeType: String
    var noticeKeyword: String?
}

let sampleData = [
    NoticeNotification(noticeTitle: "[컴소] 2024-1 컴퓨터소프트웨어공학과 타학과 수강신청 안내", noticeType: "컴퓨터소프트웨어공학과"),
    NoticeNotification(noticeTitle: "2023학년도 전기 학위수여식 안내", noticeType: "대학 공지", noticeKeyword: "학위수여식"),
]
