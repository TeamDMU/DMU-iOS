//
//  NotificationViewModel.swift
//  DMU-iOS
//
//  Created by 이예빈 on 3/26/24.
//

import Foundation

class NotificationViewModel: ObservableObject {
    @Published var userSettings: UserSettings
    
    private var notificationService = NotificationService()
    
    init(userSettings: UserSettings) {
        self.userSettings = userSettings
    }
    
    //MARK: 최초 토큰 등록
    func initToken() {
        if userSettings.fcmToken.isEmpty {
            print("FCM 토큰 없음")
            return
        }
        
        if userSettings.selectedKeywordsContents.isEmpty {
            print("선택된 키워드 없음")
            return
        }
        
        if userSettings.selectedDepartment.isEmpty {
            print("선택된 학과 없음")
            return
        }
        
        let token = userSettings.fcmToken
        let department = userSettings.selectedDepartment
        let keywords = userSettings.selectedKeywordsContents
        
        notificationService.postInitToken(token: token, department: department, topics: keywords) { result in
            switch result {
            case .success(let success):
                if success {
                    print("최초 토큰 등록 성공")
                } else {
                    print("최초 토큰 등록 실패")
                }
            case .failure(let error):
                print("최초 토큰 등록 실패: \(error.localizedDescription)")
            }
        }
    }
}
