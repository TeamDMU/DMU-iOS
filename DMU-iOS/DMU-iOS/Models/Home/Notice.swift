//
//  Notice.swift
//  DMU-iOS
//
//  Created by 이예빈 on 12/31/23.
//

import Foundation

// 추후 api 통신 연결할 때 수정할 예정
struct Notice: Identifiable {
    var id = UUID()
    var title: String
    var date: Date
    var staffName: String
    var noticeType: String
}

let sampleData = [
    Notice(title: "2022학년도 하계 계절학기 수강 신청 안내", date: Date(), staffName: "박재선", noticeType: "대학공지"),
    Notice(title: "2022년 2학기 농림축산식품부 대학장학금 안내(농업인 자녀 장학지원 확대", date: Date(), staffName: "서지혜", noticeType: "대학공지"),
    Notice(title: "DMMC 상반기 창업 육성 세미나 수강생 모집", date: Date(), staffName: "김아름", noticeType: "대학공지"),
    Notice(title: "[공학센터] 산학협력공동교육캠프 및 디자인씽킹교육 수상 안내", date: Date(), staffName: "나준현", noticeType: "대학공지"),
    Notice(title: "2022학년도 하계 계절학기 수강 신청 안내", date: Date(), staffName: "박재선", noticeType: "대학공지"),
    Notice(title: "2022학년도 하계 계절학기 수강 신청 안내", date: Date(), staffName: "박재선", noticeType: "대학공지"),
    Notice(title: "2022학년도 하계 계절학기 수강 신청 안내", date: Date(), staffName: "박재선", noticeType: "대학공지"),
    Notice(title: "2022학년도 하계 계절학기 수강 신청 안내", date: Date(), staffName: "박재선", noticeType: "대학공지"),
    Notice(title: "2022학년도 하계 계절학기 수강 신청 안내", date: Date(), staffName: "박재선", noticeType: "대학공지"),
    Notice(title: "[컴소] 2022학년도 1학기 기말고사 시간표 안내(06/02)", date: Date(), staffName: "이재천", noticeType: "학부공지"),
    Notice(title: "[컴소] 2022학년도 1학기 기말고사 시간표 안내(06/02)", date: Date(), staffName: "이재천", noticeType: "학부공지"),
    Notice(title: "[컴소] 2022학년도 1학기 기말고사 시간표 안내(06/02)", date: Date(), staffName: "이재천", noticeType: "학부공지"),
    Notice(title: "[컴소] 2022학년도 1학기 기말고사 시간표 안내(06/02)", date: Date(), staffName: "이재천", noticeType: "학부공지"),
]
