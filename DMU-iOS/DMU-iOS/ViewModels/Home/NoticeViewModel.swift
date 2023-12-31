//
//  NoticeViewModel.swift
//  DMU-iOS
//
//  Created by 이예빈 on 12/31/23.
//

import Foundation

class NoticeViewModel: ObservableObject {
    
    @Published var selectedTab: String = "대학공지"
    @Published var notices: [Notice] = sampleData
    
    func formatDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter.string(from: date)
    }
    
    func filteredNotices() -> [Notice] {
        return notices.filter { $0.noticeType == selectedTab }
    }
}
