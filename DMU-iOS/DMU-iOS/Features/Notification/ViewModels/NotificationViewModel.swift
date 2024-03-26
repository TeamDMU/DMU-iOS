//
//  NotificationViewModel.swift
//  DMU-iOS
//
//  Created by 이예빈 on 3/26/24.
//

import Foundation

class NotificationViewModel: ObservableObject {
    private var notificationService = NotificationService()
    @Published var userSettings: UserSettings
    
    init(userSettings: UserSettings) {
        self.userSettings = userSettings
    }
    
    func postUpdateKeyword(completion: @escaping (Bool, Error?) -> Void) {
        if userSettings.fcmToken.isEmpty {
            completion(false, NSError(domain: "UserSettingsError", code: 0, userInfo: [NSLocalizedDescriptionKey: "FCM 토큰 없음"]))
            return
        }
        
        if userSettings.selectedKeywordsContents.isEmpty {
            completion(false, NSError(domain: "UserSettingsError", code: 0, userInfo: [NSLocalizedDescriptionKey: "선택된 키워드 없음"]))
            return
        }
        
        let tokens = [userSettings.fcmToken]
        let keywords = userSettings.selectedKeywordsContents
        
        notificationService.postUpdateKeyword(tokens: tokens, topic: keywords) { result in
            switch result {
            case .success(let success):
                if success {
                    completion(true, nil)
                } else {
                    completion(false, NSError(domain: "UpdateKeywordError", code: 1, userInfo: [NSLocalizedDescriptionKey: "키워드 업데이트 실패"]))
                }
            case .failure(let error):
                completion(false, error)
            }
        }
    }
    
    func postDeleteKeyword(completion: @escaping (Bool, Error?) -> Void) {
        if userSettings.fcmToken.isEmpty {
            completion(false, NSError(domain: "UserSettingsError", code: 0, userInfo: [NSLocalizedDescriptionKey: "FCM 토큰 없음"]))
            return
        }
        
        if userSettings.selectedKeywordsContents.isEmpty {
            completion(false, NSError(domain: "UserSettingsError", code: 0, userInfo: [NSLocalizedDescriptionKey: "선택된 키워드 없음"]))
            return
        }
        
        let tokens = [userSettings.fcmToken]
        let keywords = userSettings.selectedKeywordsContents
        
        notificationService.postDeleteKeyword(tokens: tokens, topic: keywords) { result in
            switch result {
            case .success(let success):
                if success {
                    completion(true, nil)
                } else {
                    completion(false, NSError(domain: "UpdateKeywordError", code: 1, userInfo: [NSLocalizedDescriptionKey: "키워드 업데이트 실패"]))
                }
            case .failure(let error):
                completion(false, error)
            }
        }
    }
}
