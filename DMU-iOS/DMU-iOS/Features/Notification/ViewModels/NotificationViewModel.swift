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
    
    func postUpdateKeyword() {
        if userSettings.fcmToken.isEmpty {
            print("FCM 토큰 없음")
            return
        }
        
        if userSettings.selectedKeywordsContents.isEmpty {
            print("선택된 키워드 없음")
            return
        }
        
        let tokens = [userSettings.fcmToken]
        let keywords = userSettings.selectedKeywordsContents
        
        notificationService.postUpdateKeyword(tokens: tokens, topic: keywords) { result in
            switch result {
            case .success(let success):
                if success {
                    print("키워드 업데이트 성공")
                } else {
                    print("카워드 업데이트 실패")
                }
            case .failure(let error):
                print("키워드 업데이트 실패: \(error.localizedDescription)")
            }
        }
    }
    
    func postDeleteKeyword() {
        if userSettings.fcmToken.isEmpty {
            print("FCM 토큰 없음")
            return
        }
        
        if userSettings.selectedKeywordsContents.isEmpty {
            print("선택된 키워드 없음")
            return
        }
        
        let tokens = [userSettings.fcmToken]
        let keywords = userSettings.selectedKeywordsContents
        
        notificationService.postDeleteKeyword(tokens: tokens, topic: keywords) { result in
            switch result {
            case .success(let success):
                if success {
                    print("키워드 삭제 성공")
                } else {
                    print("카워드 삭제 실패")
                }
            case .failure(let error):
                print("키워드 삭제 실패: \(error.localizedDescription)")
            }
        }
    }
    
    func postUpdateDepartment(){
        if userSettings.fcmToken.isEmpty {
            print("FCM 토큰 없음")
            return
        }
        
        if userSettings.selectedDepartment.isEmpty {
            print("선택된 학과 없음")
            return
        }
        
        let tokens = [userSettings.fcmToken]
        let department = userSettings.selectedDepartment
        
        notificationService.postUpdateDepartment(tokens: tokens, department: department) { result in
            switch result {
            case .success(let success):
                if success {
                    print("학과 업데이트 성공")
                } else {
                    print("학과 업데이트 실패")
                }
            case .failure(let error):
                print("학과 업데이트 실패: \(error.localizedDescription)")
            }
        }
    }
    
    func postDeleteDepartment(){
        if userSettings.fcmToken.isEmpty {
            print("FCM 토큰 없음")
            return
        }
        
        if userSettings.selectedDepartment.isEmpty {
            print("선택된 학과 없음")
            return
        }
        
        let tokens = [userSettings.fcmToken]
        let department = userSettings.selectedDepartment
        
        notificationService.postDeleteDepartment(tokens: tokens, department: department) { result in
            switch result {
            case .success(let success):
                if success {
                    print("학과 삭제 성공")
                } else {
                    print("학과 삭제 실패")
                }
            case .failure(let error):
                print("학과 삭제 실패: \(error.localizedDescription)")
            }
        }
    }
}
