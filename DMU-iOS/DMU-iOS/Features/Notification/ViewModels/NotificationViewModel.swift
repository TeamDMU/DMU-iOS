//
//  NotificationViewModel.swift
//  DMU-iOS
//
//  Created by 이예빈 on 1/14/24.
//

import Foundation

class NotificationViewModel: ObservableObject {
    
    @Published var notices = sampleData
    
    func dismiss() {
        // 알림 뷰 닫기 처리
    }
    
    func editKeywords() {
        // 키워드 편집 처리
    }
}
