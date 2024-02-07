//
//  Notice.swift
//  DMU-iOS
//
//  Created by 이예빈 on 12/31/23.
//

import Foundation

// MARK: -추후 api 통신 연결할 때 수정할 예정
struct Notice: Identifiable {
    
    var id = UUID()
    var noticeTitle: String
    var noticeDate: Date
    var noticeStaffName : String
    var noticeURL : String
}

struct UniversityNotice: Identifiable {
    var id: UUID { notice.id }
    var notice: Notice
    var noticeKeyword: String
}

struct DepartmentNotice: Identifiable {
    var id: UUID { notice.id }
    var notice: Notice
    var noticeDepartment: String
}

// MARK: - 공지사항 더미데이터
let sampleUniversityNotices = [
    UniversityNotice(notice: Notice(noticeTitle: "2023학년도 전기 학위수여식 안내", noticeDate: Date(), noticeStaffName: "선윤진", noticeURL: "https://www.dongyang.ac.kr/bbs/dongyang/7/123827/artclView.do?layout=unknown"), noticeKeyword: "학위수여식")
]

let sampleDepartmentNotices = [
    DepartmentNotice(notice: Notice(noticeTitle: "[컴소] 2024-1 컴퓨터소프트웨어공학과 타학과 수강신청 안내", noticeDate: Date(), noticeStaffName: "오준영", noticeURL: "https://www.dongyang.ac.kr/combBbs/dmu_23222/14/123828/view.do?layout=unknown"), noticeDepartment: "컴퓨터소프트웨어공학과"),
    DepartmentNotice(notice: Notice(noticeTitle: "[컴소] 2024-1 컴퓨터소프트웨어공학과 타학과 수강신청 안내2", noticeDate: Date(), noticeStaffName: "오준영", noticeURL: "https://www.dongyang.ac.kr/combBbs/dmu_23222/14/123828/view.do?layout=unknown"), noticeDepartment: "컴퓨터소프트웨어공학과"),
    DepartmentNotice(notice: Notice(noticeTitle: "[컴소] 2024-1 컴퓨터소프트웨어공학과 타학과 수강신청 안내3", noticeDate: Date(), noticeStaffName: "오준영", noticeURL: "https://www.dongyang.ac.kr/combBbs/dmu_23222/14/123828/view.do?layout=unknown"), noticeDepartment: "컴퓨터소프트웨어공학과"),
]
