//
//  APIConstants.swift
//  DMU-iOS
//
//  Created by 이예빈 on 1/26/24.
//

import Foundation

// API에 필요한 상수 정의
struct APIConstants {
    
    // API 기본 URL, 실패 시 Fallback URL
    static var baseURL: String {
        return Bundle.main.readSecret(key: "baseURL") ?? "Fallback URL"
    }
    
    // 학사일정 API 엔드포인트
    static let scheduleEndpoint = "schedule"
    
    // 식단표 API 엔드포인트
    static let menuEndpoint = "cafeteria"
    
    // 대학공지 API 엔드포인트
    static let universityNoticeEndpoint = "universityNotice"
    
    // 학부공지 API 엔드포인트
    static let departmentNoticeEndpoint = "departmentNotice"
    
    // 공지 검색 API 엔드포인트
    static let searchEndpoint = "notice"
    
    // HTTP 필드 이름
    static let contentType = "Content-Type"
    
    // HTTP 필드값
    static let applicationJSON = "application/json"
    static let multipartFormData = "multipart/form"
}

extension APIConstants {
    // 토큰이 없는 경우 사용하는 HTTP 헤더
    static var noTokenHeader: Dictionary<String, String> {
        [contentType: applicationJSON]
    }
}

// Bundle Extension -> Secrets.plist 데이터 가져오기
extension Bundle {
    func readSecret(key: String) -> String? {
        guard let path = self.path(forResource: "Secrets", ofType: "plist"),
              let dict = NSDictionary(contentsOfFile: path),
              let value = dict[key] as? String else {
            return nil
        }
        
        return value
    }
}
